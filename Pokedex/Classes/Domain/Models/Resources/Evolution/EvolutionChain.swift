//
//  EvolutionChain.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-03.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class EvolutionChain: Resource {
    let id: Int
    let babyTriggerItem: NamedResource
    let chain: ChainLink
    required init?(json: JSON) {
        return nil
    }
}
