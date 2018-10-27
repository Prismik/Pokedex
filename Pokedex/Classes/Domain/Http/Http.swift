//
//  Http.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol HttpEndpoint {
    var baseUrl: String { get }
    var url: URLComponents? { get }
    var method: Http.Method { get }
    var bodyData: Any? { get }
    var queryData: [URLQueryItem]?  { get }
    var request: URLRequest? { get }
    func parseResponse(json: JSON) -> Any?
}

class Http {
    private static let executionQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
    private static var session: URLSession!

    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    enum MimeType: String {
        case wav = "audio/wav"
    }

    enum Response {
        case success(data: Any?)
        case failure(error: Error)
    }

    class func initSession() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15
        sessionConfig.timeoutIntervalForResource = 15
        session = URLSession(configuration: sessionConfig)
    }

    private class func buildBasicRequest(urlComponents: URLComponents?, method: Http.Method, queryData: [URLQueryItem]?) -> URLRequest? {
        guard var urlComponents = urlComponents else { return nil }
        urlComponents.queryItems = queryData
        guard let url = urlComponents.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let token: String?
        if let storedToken = LocalStorage.get(LocalStorage.authTokenKey) {
            token = "Bearer \(storedToken)"
        } else {
            token = nil
        }

        request.setValue(token, forHTTPHeaderField: "Authorization")

        return request
    }

    class func buildRequest(url: URLComponents?, method: Http.Method, queryData: [URLQueryItem]?, bodyData: Any?) -> URLRequest? {
        guard var request = Http.buildBasicRequest(urlComponents: url, method: method, queryData: queryData) else {
            return nil
        }

        if let jsonData = bodyData {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: jsonData)
            } catch let error {
                print(error.localizedDescription)
            }
        }

        return request
    }

    class func request(url: URL, handler: @escaping (_ response: Http.Response) -> Void) {
        let request = URLRequest(url: url)
        let completionHandler = { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            DispatchQueue.main.async {
                guard error == nil, let data = data, let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        handler(Http.Response.failure(error: NSError()))
                        return
                }

                handler(Http.Response.success(data: data))
            }
        }

        executionQueue.async {
            session.dataTask(with: request, completionHandler: completionHandler).resume()
        }
    }

    class func request(_ endpoint: HttpEndpoint, handler: @escaping (_ response: Http.Response) -> Void) {
        guard let request = endpoint.request else { return }
        let completionHandler = { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            DispatchQueue.main.async {
                guard error == nil, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else {
                    let code = (response as? HTTPURLResponse)?.statusCode ?? 0
                    let message: String
                    do {
                        if let data = data {
                            let json = try JSON(data: data)
                            message = json["description"].stringValue
                        } else {
                            message = "Http error"
                        }
                    } catch {
                        message = "Http error"
                    }

                    handler(Http.Response.failure(error: NSError()))
                    return
                }

                do {
                    if data == nil || data?.isEmpty ?? true {
                        handler(Http.Response.success(data: nil))
                    } else {
                        let json = try JSON(data: data!)
                        let parsedData = endpoint.parseResponse(json: json)
                        handler(Http.Response.success(data: parsedData))
                    }
                } catch {
                    handler(Http.Response.success(data: nil))
                    print("WARNING: Parsing error")
                }
            }
        }


        executionQueue.async {
            session.dataTask(with: request, completionHandler: completionHandler).resume()
        }
    }
}
