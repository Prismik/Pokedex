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
            return UIColor.normal
        case "fire":
            return UIColor.fire
        case "water":
            return UIColor.water
        case "electric":
            return UIColor.electric
        case "grass":
            return UIColor.grass
        case "ice":
            return UIColor.ice
        case "fighting":
            return UIColor.fighting
        case "poison":
            return UIColor.poison
        case "ground":
            return UIColor.ground
        case "flying":
            return UIColor.flying
        case "psychic":
            return UIColor.psychic
        case "bug":
            return UIColor.bug
        case "rock":
            return UIColor.rock
        case "ghost":
            return UIColor.ghost
        case "dragon":
            return UIColor.dragon
        case "dark":
            return UIColor.dark
        case "steel":
            return UIColor.steel
        case "fairy":
            return UIColor.fairy
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
