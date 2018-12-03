//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-28.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    var mainView: PokemonDetailsView {
        return view as! PokemonDetailsView
    }

    private let pokemon: Pokemon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)

        title = pokemon.name.capitalized
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let detailsView = PokemonDetailsView(pokemon: pokemon)
        self.view = detailsView
    }
}
