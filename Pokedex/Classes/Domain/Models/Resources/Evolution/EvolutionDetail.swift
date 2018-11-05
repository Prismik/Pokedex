//
//  EvolutionDetail.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class EvolutionDetail: Resource {
    let item: NamedResource<Item>
    
    required init?(json: JSON) {
        return nil
    }
}
