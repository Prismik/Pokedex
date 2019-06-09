//
//  UnnamedResource.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-03.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class UnnamedResource<T: Resource>: Resource {
    let url: String
    private(set) var resource: T?

    required init?(json: JSON) {
        guard let url = json["url"].string else { return nil }
        self.url = url
        self.resource = nil
    }

    func fetch() -> AsyncTask<T> {
        if let resource = resource {
            let task = TaskFactory.shared.makeAsync(resource: T.self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                task.didSucceed?(resource)
            })
            return task
        } else {
            guard let resourceUrl = URL(string: url) else { return AsyncTask() }
            let task = TaskFactory.shared.makeAsync(resource: T.self)
            Http.request(url: resourceUrl) { (response) in
                switch response {
                case .success(let data):
                    guard let data = data as? Data, let json = data.jsonValue else { return }
                    self.resource = T(json: json)
                    task.didSucceed?(self.resource)
                case .failure:
                    task.didFail?(NSError())
                }
            }
            return task
        }
    }
}
