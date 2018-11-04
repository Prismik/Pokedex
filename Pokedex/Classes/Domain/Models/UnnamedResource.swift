//
//  UnnamedResource.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-03.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class UnnamedResource: Resource {
    let url: String
    required init?(json: JSON) {
        guard let url = json["url"].string else { return nil }
        self.url = url
    }
}
