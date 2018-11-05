//
//  Name.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

class Name: Resource {
    let name: String
    let language: NamedResource<Language>
    
    required init?(json: JSON) {
        return nil
    }
}
