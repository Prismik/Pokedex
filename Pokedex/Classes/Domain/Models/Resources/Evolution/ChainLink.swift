//
//  ChainLink.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class ChainLink: Resource {
    let isBaby: Bool
    let species: NamedResource
    let evolutionDetails: [EvolutionDetail]
    let evolvesTo: [ChainLink]
    
    required init?(json: JSON) {
        return nil
    }
}
