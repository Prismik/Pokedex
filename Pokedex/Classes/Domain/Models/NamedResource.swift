//
//  NamedResource.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class NamedResource<T: Resource>: Resource {
    let name: String
    let url: String
    private(set) var resource: T?

    required init?(json: JSON) {
        guard let name = json["name"].string else { return nil }
        guard let url = json["name"].string else { return nil }

        self.name = name
        self.url = url
        self.resource = nil
    }

    func fetch() {
        guard let resourceUrl = URL(string: url) else { return }
        Http.request(url: resourceUrl) { (response) in
            switch response {
            case .success(let data):
                guard let data = data as? Data, let json = data.jsonValue else { return }
                self.resource = T(json: json)
            case .failure:
                break // TODO Retry
            }
        }
    }
}
