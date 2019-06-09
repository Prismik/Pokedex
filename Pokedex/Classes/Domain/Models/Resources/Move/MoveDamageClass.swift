//
//  MoveDamageClass.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class MoveDamageClass: Resource {
    let id: Int
    let name: String
    var color: UIColor {
        switch name {
        case "status":
            return UIColor.white
        case "physical":
            return UIColor.white
        case "special":
            return UIColor.white
        default:
            return .white
        }
    }

    required init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }
        self.id = id
        self.name = name
    }
}
