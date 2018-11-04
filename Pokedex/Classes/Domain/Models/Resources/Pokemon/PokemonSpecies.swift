//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-01.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class PokemonSpecies: Resource {
    let id: Int
    let name: String

    /// The order in which species should be sorted. Based on National Dex order, except families are grouped together and sorted by stage.
    let order: Int

    /// The chance of this Pokémon being female, in eighths; or -1 for genderless.
    let genderRate: Int

    /// The base capture rate; up to 255. The higher the number, the easier the catch.
    let captureRate: Int

    let isBaby: Bool

    /// Initial hatch counter: one must walk 255 × (hatchCounter + 1) steps before this Pokemon's egg hatches, unless utilizing bonuses like Flame Body's.
    let hatchCounter: Int

    let evolutionChain: Resource
    let evolvesFromSpecies: NamedResource

    required init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }
        guard let order = json["order"].int else { return nil }
        guard let chain = UnnamedResource(json: json["evolution_chain"]) else { return nil }
        guard let evolvesFrom = NamedResource(json: json["evolves_from"]) else { return nil }

        self.id = id
        self.name = name
        self.order = order
        self.genderRate = json["gender_rate"].int ?? -1
        self.isBaby = json["is_baby"].bool ?? false
        self.captureRate = json["capture_rate"].int ?? 255
        self.hatchCounter = json["hatch_counter"].int ?? 0
        self.evolutionChain = chain
        self.evolvesFromSpecies = evolvesFrom
    }
}
