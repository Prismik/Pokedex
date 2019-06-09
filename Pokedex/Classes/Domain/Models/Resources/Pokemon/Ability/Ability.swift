//
//  Ability.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Ability: Resource {
    let id: Int
    let name: String
    let flavorTexts: [AbilityFlavorText] //flavor_text_entries
//    id
//    The identifier for this resource.
//    integer
//    name
//    The name for this resource.
//    string
//    is_main_series
//    Whether or not this ability originated in the main series of the video games.
//    boolean
//    generation
//    The generation this ability originated in.
//    NamedAPIResource (Generation)
//    names
//    The name of this resource listed in different languages.
//    list Name
//    effect_entries
//    The effect of this ability listed in different languages.
//    list VerboseEffect
//    effect_changes
//    The list of previous effects this ability has had across version groups.
//    list AbilityEffectChange
//    flavor_text_entries
//    The flavor text of this ability listed in different languages.
//    list AbilityFlavorText
//    pokemon

    required init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }

        self.id = id
        self.name = name
        self.flavorTexts = []
    }
}
