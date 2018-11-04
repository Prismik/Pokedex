//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-28.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class PokemonDetailsView: UIView {
//    let name: String
//    let baseExperience: Int
//    let abilities: [PokemonAbility]
//    let forms: [NamedResource]
//    let moves: [PokemonMove]
//    let sprite: Sprite
    private let imageView = UIImageView()
    private let abilitiesView = UIView()
    init() {
        super.init(frame: .zero)

        addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
