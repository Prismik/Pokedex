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

    override func viewDidLoad() {
        super.viewDidLoad()

        let group = DispatchGroup()
        pokemon.moves.forEach({
            group.enter()
            $0.move.fetch().onSuccess({ (_) in
                group.leave()
            }).onFailure({(_) in
                group.leave()
            })
        })

        group.notify(queue: .main, execute: { [weak self] in
            self?.mainView.didUpdateMoves()
        })
    }
}
