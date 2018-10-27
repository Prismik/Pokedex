//
//  PokemonType.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class PokemonType: Resource {
    let slot: Int
    let type: NamedResource

    init?(json: JSON) {
        guard let slot = json["slot"].int else { return nil }
        guard let type = NamedResource(json: json["name"]) else { return nil }
        
        self.slot = slot
        self.type = type
    }
}
