//
//  Ability.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Ability: Resource {
    let id: Int
    let name: String
    let flavorTexts: [AbilityFlavorText] //flavor_text_entries

    required init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }

        self.id = id
        self.name = name
        self.flavorTexts = []
    }
}
