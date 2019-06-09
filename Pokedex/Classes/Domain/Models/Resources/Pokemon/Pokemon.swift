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
    let stats: [PokemonStat]

    var mainColor: UIColor? {
        return types.last?.color
    }

    required init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }
        guard let baseXp = json["base_experience"].int else { return nil }
        let abilities: [PokemonAbility] = json["abilities"].arrayValue.compactMap({
            return PokemonAbility(json: $0)
        })

        let forms: [NamedResource<Form>] = json["forms"].arrayValue.compactMap({ form -> NamedResource<Form>? in
            return NamedResource<Form>(json: form)
        })

        let moves: [PokemonMove] = json["moves"].arrayValue.compactMap({ move -> PokemonMove? in
            return PokemonMove(json: move)
        })

        guard let species = NamedResource<PokemonSpecies>(json: json["species"]) else { return nil }

        let types: [PokemonType] = json["types"].arrayValue.compactMap({ type -> PokemonType? in
            return PokemonType(json: type)
        })

        let stats: [PokemonStat] = json["stats"].arrayValue.compactMap({ stat -> PokemonStat? in
            return PokemonStat(json: stat)
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
        self.stats = stats
    }
}
