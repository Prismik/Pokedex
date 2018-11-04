//
//  Data+toJson.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-04.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

extension Data {
    var jsonValue: JSON? {
        let json: JSON?
        do {
            json = try JSON(data: self)
        } catch {
            json = nil
        }

        return json
    }
}
