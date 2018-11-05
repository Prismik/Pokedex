//
//  Language.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Language: Resource {
    let id: Int
    let name: String

    /// Whether or not the games are published in this language.
    let official: Bool

    /// The two-letter code of the country where this language is spoken. Note that it is not unique.
    let iso639: String

    /// The two-letter code of the language. Note that it is not unique.
    let iso3119: String

    let names: [Name]

    required init?(json: JSON) {
        return nil
    }
}
