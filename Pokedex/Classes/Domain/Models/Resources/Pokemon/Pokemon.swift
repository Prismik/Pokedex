//
//  Pokemon.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-26.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Pokemon: Resource {
    let id: Int
    let name: String
    let baseExperience: Int
    let abilities: [PokemonAbility]
    let forms: [NamedResource<Form>]
    let moves: [PokemonMove]
    let sprite: Sprite
    let species: NamedResource<PokemonSpecies>
    let types: [PokemonType]

    var mainColor: UIColor? {
        return types.last?.color
    }

    required init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }
        guard let baseXp = json["base_experience"].int else { return nil }
        let abilities: [PokemonAbility] = json["abilities"].arrayValue.reduce([], { (values, json) -> [PokemonAbility] in
            let ability = PokemonAbility(json: json)
            return ability == nil ? values : values + [ability!]
        })

        let forms: [NamedResource<Form>] = json["forms"].arrayValue.reduce([], { (values, json) -> [NamedResource<Form>] in
            let form = NamedResource<Form>(json: json)
            return form == nil ? values : values + [form!]
        })

        let moves: [PokemonMove] = json["moves"].arrayValue.reduce([], { (values, json) -> [PokemonMove] in
            let move = PokemonMove(json: json)
            return move == nil ? values : values + [move!]
        })

        guard let species = NamedResource<PokemonSpecies>(json: json["species"]) else { return nil }

        let types: [PokemonType] = json["types"].arrayValue.reduce([], { (values, json) -> [PokemonType] in
            let pokemonType = PokemonType(json: json)
            return pokemonType == nil ? values : values + [pokemonType!]
        })

        self.id = id
        self.name = name
        self.baseExperience = baseXp
        self.abilities = abilities
        self.forms = forms
        self.moves = moves
        self.sprite = Sprite(json: json["sprites"])
        self.species = species
        self.types = types
    }
}
