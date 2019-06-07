//
//  PokeApi.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation
import SwiftyJSON

class PokeApi {
    enum Endpoints: HttpEndpoint {
        case pokemon(name: String)
        case pokemons
        case species(name: String)
        case next(offset: Int, limit: Int)

        var baseUrl: String {
            return "https://pokeapi.co/api/v2"
        }

        var url: URLComponents? {
            switch self {
            case .pokemon(let name):
                return URLComponents(string: "\(baseUrl)/pokemon/\(name)")
            case .pokemons:
                return URLComponents(string: "\(baseUrl)/pokemon")
            case .species(let name):
                return URLComponents(string: "\(baseUrl)/pokemon-species/\(name)")
            case .next:
                return URLComponents(string: "\(baseUrl)/pokemon")
            }
        }

        var method: Http.Method {
            return .get
        }

        var queryData: [URLQueryItem]? {
            switch self {
            case .next(let offset, let limit):
                return [
                    URLQueryItem(name: "offset", value: String(offset)),
                    URLQueryItem(name: "limit", value: String(limit))
                ]
            default:
                return nil
            }
        }

        var bodyData: Any? {
            return nil
        }

        var request: URLRequest? {
            return Http.buildRequest(url: url, method: method, queryData: queryData, bodyData: bodyData)
        }

        var discardResponse: Bool {
            return false
        }

        func parseResponse(json: JSON) -> Any? {
            switch self {
            case .pokemon:
                return Pokemon(json: json)
            case .pokemons, .next:
                return PaginatedResources<NamedResource<Pokemon>>(json: json)
            case .species:
                return PokemonSpecies(json: json)
            default:
                return nil
            }
        }
    }

    class func request(_ endpoint: PokeApi.Endpoints, handler: @escaping (_ response: Http.Response) -> Void) {
        Http.request(endpoint, handler: handler)
    }
}
