//
//  Move.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Move: Resource {
    let id: Int
    let name: String
    let accuracy: Int
    let power: Int
    let pp: Int
    let type: NamedResource<Type>
    let damageClass: NamedResource<MoveDamageClass>

    required init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }
        guard let accuracy = json["accuracy"].int else { return nil }
        guard let power = json["power"].int else { return nil }
        guard let type = NamedResource<Type>(json: json["type"]) else { return nil }
        guard let pp = json["pp"].int else { return nil }
        guard let damageClass = NamedResource<MoveDamageClass>(json: json["damage_class"]) else { return nil }

        self.id = id
        self.name = name
        self.accuracy = accuracy
        self.power = power
        self.pp = pp
        self.type = type
        self.damageClass = damageClass
    }
}
