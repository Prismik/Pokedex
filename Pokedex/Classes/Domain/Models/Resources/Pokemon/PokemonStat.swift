//
//  PokemonStat.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class PokemonStat: Resource {
    let baseValue: Int
    let effortValue: Int
    let stat: NamedResource
    
    init?(json: JSON) {
        guard let value = json["base_stat"].int else { return nil }
        guard let effort = json["effort"].int else { return nil }
        guard let stat = NamedResource(json: json["stat"]) else { return nil }
        
        self.baseValue = value
        self.effortValue = effort
        self.stat = stat
    }
}
