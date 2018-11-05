//
//  PokemonMove.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class PokemonMove: Resource {
    let move: NamedResource<Move>
    // todo version_group_details

    required init?(json: JSON) {
        guard let move = NamedResource<Move>(json: json["move"]) else { return nil }

        self.move = move
    }
}
