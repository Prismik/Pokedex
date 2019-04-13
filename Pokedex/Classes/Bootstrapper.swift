//
//  Bootstrapper.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class Bootstrapper {
    func bootstrap() {
        Http.initSession()
    }

    func configure(window: UIWindow) {
        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.white
    }
}
