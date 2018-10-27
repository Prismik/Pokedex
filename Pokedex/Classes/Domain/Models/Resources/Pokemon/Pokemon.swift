//
//  Pokemon.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-26.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Pokemon {
    let id: Int
    let name: String
    let baseExperience: Int
    let abilities: [PokemonAbility]
    let forms: [NamedResource]
    let moves: [PokemonMove]
    let sprite: Sprite

    init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }
        guard let baseXp = json["base_experience"].int else { return nil }
        let abilities: [PokemonAbility] = json["abilities"].arrayValue.reduce([], { (values, json) -> [PokemonAbility] in
            let ability = PokemonAbility(json: json)
            return ability == nil ? values : values + [ability!]
        })

        let forms: [NamedResource] = json["forms"].arrayValue.reduce([], { (values, json) -> [NamedResource] in
            let form = NamedResource(json: json)
            return form == nil ? values : values + [form!]
        })

        let moves: [PokemonMove] = json["moves"].arrayValue.reduce([], { (values, json) -> [PokemonMove] in
            let move = PokemonMove(json: json)
            return move == nil ? values : values + [move!]
        })

        self.id = id
        self.name = name
        self.baseExperience = baseXp
        self.abilities = abilities
        self.forms = forms
        self.moves = moves
        self.sprite = Sprite(json: json["sprites"])
    }
}
