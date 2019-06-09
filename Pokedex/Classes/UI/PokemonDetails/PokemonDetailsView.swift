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
    private let statsView = StatsView()
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(frame: .zero)

        if let spriteUrl = pokemon.sprite.frontImageUrl {
            imageView.loadImage(from: spriteUrl)
        }

        addSubview(imageView)
        addSubview(statsView)
        backgroundColor = .white

        let stats: [StatViewData] = pokemon.stats.map({
            return StatViewData(value: $0.baseValue, name: $0.stat.name, color: .pokedexRed)
        })
        statsView.configure(stats: stats)
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

    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.pin.top(20).hCenter().size(75)
        statsView.pin.bottom(20).width(width * 0.6).height(width * 0.6).hCenter()
    }
}
