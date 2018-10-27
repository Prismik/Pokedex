//
//  PokemonAbility.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-26.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class PokemonAbility: Resource {
    let isHidden: Bool
    let slot: Int
    let ability: NamedResource

    init?(json: JSON) {
        guard let hidden = json["is_hidden"].bool else { return nil }
        guard let slot = json["slot"].int else { return nil }
        guard let ability = NamedResource(json: json["ability"]) else { return nil }

        self.isHidden = hidden
        self.slot = slot
        self.ability = ability
    }
}
