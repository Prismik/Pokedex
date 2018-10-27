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
        PokeApi.request(.pokemons) { [weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let data):
                guard let paginatedResult = data as? PaginatedResources<NamedResource> else { return }
                strongSelf.mainView.configure(resources: paginatedResult.results)
            case .failure:
                break
            }
        }
    }
}

