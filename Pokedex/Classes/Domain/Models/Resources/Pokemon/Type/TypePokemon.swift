//
//  TypePokemon.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class TypePokemon:Resource {
    let slot: Int
    let pokemon: NamedResource<Pokemon>

    required init?(json: JSON) {
        guard let slot = json["slot"].int else { return nil }
        guard let pokemon = NamedResource<Pokemon>(json: json["pokemon"]) else { return nil }

        self.slot = slot
        self.pokemon = pokemon
    }
}
