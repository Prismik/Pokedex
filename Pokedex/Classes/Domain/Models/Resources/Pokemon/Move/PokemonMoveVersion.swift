//
//  PokemonMoveVersion.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-06-09.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class PokemonMoveVersion: Resource {
    let learningMethod: NamedResource<MoveLearnMethod>
    let versionGroup: NamedResource<VersionGroup>
    let learnedAtLevel: Int
    required init?(json: JSON) {
        guard let method = NamedResource<MoveLearnMethod>(json: json["move_learn_method"]) else { return nil }
        guard let group = NamedResource<VersionGroup>(json: json["version_group"]) else { return nil }
        guard let learnAt = json ["level_learned_at"].int else { return nil }

        self.learningMethod = method
        self.versionGroup = group
        self.learnedAtLevel = learnAt
    }
}
