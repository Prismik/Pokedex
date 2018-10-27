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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Line", style: .plain, target: self, action: #selector(toggleLayout))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = PokemonListView()
        view.delegate = self
        self.view = view

        PokeApi.request(.pokemons) { [weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let data):
                guard let paginatedResult = data as? PaginatedResources<NamedResource> else { return }
                strongSelf.mainView.configure(resources: paginatedResult.results)
            case .failure:
                break
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
    }

    @objc private func toggleLayout() {
        mainView.toggleLayout()
        navigationItem.rightBarButtonItem?.title = mainView.layout.title
    }
}

extension PokemonListViewController: PokemonListViewDelegate {
    func fetchDetails(for resource: NamedResource, handler: @escaping (Pokemon) -> Void) {
        PokeApi.request(.pokemon(name: resource.name)) { (response) in
            switch response {
            case .success(let data):
                guard let pokemon = data as? Pokemon else { return }
                handler(pokemon)
            case .failure:
                break
            }
        }
    }
}
