//
//  NamedResource.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class NamedResource: Resource {
    let name: String
    let url: String

    init?(json: JSON) {
        guard let name = json["name"].string else { return nil }
        guard let url = json["name"].string else { return nil }

        self.name = name
        self.url = url
    }
}
