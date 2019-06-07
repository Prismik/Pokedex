//
//  PaginatedResources.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class PaginatedResources<T: Resource>: Resource {
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]

    private(set) var offset: Int = 0
    let limit: Int = 20

    required init?(json: JSON) {
        guard let count = json["count"].int else { return nil }
        let resultItems: [T] = json["results"].arrayValue.reduce([], { (values, json) -> [T] in
            let value = T(json: json)
            return value == nil ? values : values + [value!]
        })

        self.count = count
        self.next = json["next"].string
        if let url = URLComponents(string: self.next ?? ""),
            let offset = url.queryItems?.first(where: { $0.name == "offset" }) {
            self.offset = Int(offset.value ?? "0") ?? 0
        }


        self.previous = json["previous"].string
        self.results = resultItems
    }
}
