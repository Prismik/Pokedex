//
//  Type.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Type: Resource {
    let id: Int
    let name: String
    let damageRelations: TypeRelations
//    let gameIndices: [GenerationGameIndex]
//    let generation: NamedResource<Generation>
    let pokemons: [TypePokemon]
    let moves: [NamedResource<Move>]
    required init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }
        guard let relations = TypeRelations(json: json["damage_relations"]) else { return nil }
        let pokemons: [TypePokemon] = json["pokemon"].arrayValue.compactMap({ pokemon -> TypePokemon? in
            return TypePokemon(json: json)
        })

        let moves: [NamedResource<Move>] = json["moves"].arrayValue.compactMap({ move -> NamedResource<Move>? in
            return NamedResource<Move>(json: move)
        })

        self.id = id
        self.name = name
        self.damageRelations = relations
        self.pokemons = pokemons
        self.moves = moves
    }
}
