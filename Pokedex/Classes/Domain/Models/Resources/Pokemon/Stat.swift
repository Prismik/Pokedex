//
//  Stat.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Stat: Resource {
    let id: Int
    let name: String
    let gameIndex: Int
    let battleOnly: Bool

    required init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }
        guard let index = json["game_index"].int else { return nil }
        guard let isBattleOnly = json["is_battle_only"].bool else { return nil }

        self.id = id
        self.name = name
        self.gameIndex = index
        self.battleOnly = isBattleOnly
    }
}
