//
//  VersionGroup.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-06-09.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class VersionGroup: Resource {
    let id: Int
    let name: String
    let sortOrder: Int
    // generation
    let moveLearningMethods: [NamedResource<MoveLearnMethod>]
    // pokedexes
    // versions
    required init?(json: JSON) {
        return nil
    }
}
