//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-26.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {
    var mainView: PokemonListView {
        return view as! PokemonListView
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        edgesForExtendedLayout = []
        title = "Pokemons"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = PokemonListView()
        self.view = view
    }
}

