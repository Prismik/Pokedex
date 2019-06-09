//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-28.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class PokemonDetailsView: UIView {
    private var pokemon: Pokemon

    private let imageView = UIImageView()
    private let abilitiesView = UIView()
    private let movesView = UIView()
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(frame: .zero)

        if let spriteUrl = pokemon.sprite.frontImageUrl {
            imageView.loadImage(from: spriteUrl)
        }

        addSubview(imageView)

        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didUpdateMoves() {
        pokemon.moves.compactMap({ return $0.move.resource }).forEach({
            print("\($0.name) - \($0.accuracy) ACC, \($0.power) PWR")
        })

        setNeedsLayout()
    }
}
