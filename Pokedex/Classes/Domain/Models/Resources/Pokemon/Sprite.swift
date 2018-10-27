//
//  Sprite.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Sprite: Resource {
    let frontImageUrl: String?
    let frontShinyImageUrl: String?
    let backImageUrl: String?
    let backShinyImageUrl: String?

    init(json: JSON) {
        self.frontImageUrl = json["front_default"].string
        self.backImageUrl = json["back_default"].string

        self.frontShinyImageUrl = json["front_shiny"].string
        self.backShinyImageUrl = json["back_shiny"].string
    }
}
