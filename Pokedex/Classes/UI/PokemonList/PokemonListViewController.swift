//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-26.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

protocol PokemonListViewControllerDelegate: class {
    func pokemonListViewControllerDidPresentBottomMenu(_ listViewController: PokemonListViewController)
    func pokemonListViewController(_ listViewController: PokemonListViewController, didPresentDetail pokemon: Pokemon)
}

class PokemonListViewController: UIViewController {
    var mainView: PokemonListView {
        return view as! PokemonListView
    }

    weak var delegate: PokemonListViewControllerDelegate?
    weak var interactor: BottomMenuInteractor?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private var currentResult: PaginatedResources<NamedResource<Pokemon>>?

    init() {
        super.init(nibName: nil, bundle: nil)

        edgesForExtendedLayout = []
        title = "Pokemons"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Line", style: .plain, target: self, action: #selector(toggleLayout))
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
            strongSelf.parse(paginatedResponse: response)
        }
    }

    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.pokedexRed
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
    }

    @objc private func toggleLayout() {
        mainView.toggleLayout()
        navigationItem.rightBarButtonItem?.title = mainView.layout.title
    }

    private func parse(paginatedResponse: Http.Response) {
        switch paginatedResponse {
        case .success(let data):
            guard let paginatedResult = data as? PaginatedResources<NamedResource<Pokemon>> else { return }
            currentResult = paginatedResult
            mainView.configure(resources: paginatedResult.results)
        case .failure:
            break
        }
    }
}

extension PokemonListViewController: PokemonListViewDelegate {
    func fetchNextPage() {
        guard let currentPagination = currentResult else { return }
        PokeApi.request(.next(offset: currentPagination.offset, limit: currentPagination.limit)) { [weak self] (response) in
            guard let strongSelf = self else { return }
            strongSelf.parse(paginatedResponse: response)
        }
    }

    func fetchDetails(for resource: NamedResource<Pokemon>, handler: @escaping (Pokemon) -> Void) {
        resource.fetch().onSuccess({ (data) in
            guard let pokemon = data else { return }
            handler(pokemon)
        }).onFailure({ (error) in
            print("woops")
        })
    }

    func showSpeciesDetails(for pokemon: NamedResource<Pokemon>) {
        guard let details = pokemon.resource else { return }
        delegate?.pokemonListViewController(self, didPresentDetail: details)
    }

    func didPan(_ progress: CGFloat, state: UIGestureRecognizerState) {
        MenuHelper.mapGestureStateToInteractor(gestureState: state, progress: progress, interactor: interactor, presenting: false) {
            delegate?.pokemonListViewControllerDidPresentBottomMenu(self)
        }
    }
}
