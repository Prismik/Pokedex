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
    let versionGroupDetails: [PokemonMoveVersion]

    required init?(json: JSON) {
        guard let move = NamedResource<Move>(json: json["move"]) else { return nil }
        let details: [PokemonMoveVersion] = json["version_group_details"].arrayValue.compactMap({ move -> PokemonMoveVersion? in
            return PokemonMoveVersion(json: move)
        })
        self.move = move
        self.versionGroupDetails = details
    }
}
