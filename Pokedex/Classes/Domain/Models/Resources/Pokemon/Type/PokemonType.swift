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
    let type: NamedResource<Type>
    var color: UIColor {
        switch type.name.lowercased() {
        case "normal":
            return UIColor.PokemonType.normal
        case "fire":
            return UIColor.PokemonType.fire
        case "water":
            return UIColor.PokemonType.water
        case "electric":
            return UIColor.PokemonType.electric
        case "grass":
            return UIColor.PokemonType.grass
        case "ice":
            return UIColor.PokemonType.ice
        case "fighting":
            return UIColor.PokemonType.fighting
        case "poison":
            return UIColor.PokemonType.poison
        case "ground":
            return UIColor.PokemonType.ground
        case "flying":
            return UIColor.PokemonType.flying
        case "psychic":
            return UIColor.PokemonType.psychic
        case "bug":
            return UIColor.PokemonType.bug
        case "rock":
            return UIColor.PokemonType.rock
        case "ghost":
            return UIColor.PokemonType.ghost
        case "dragon":
            return UIColor.PokemonType.dragon
        case "dark":
            return UIColor.PokemonType.dark
        case "steel":
            return UIColor.PokemonType.steel
        case "fairy":
            return UIColor.PokemonType.fairy
        default:
            return .white
        }
    }

    required init?(json: JSON) {
        guard let slot = json["slot"].int else { return nil }
        guard let type = NamedResource<Type>(json: json["type"]) else { return nil }
        
        self.slot = slot
        self.type = type
    }
}
