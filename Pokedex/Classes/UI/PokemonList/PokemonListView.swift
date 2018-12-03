//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

protocol PokemonListViewDelegate: class {
    func fetchDetails(for resource: NamedResource<Pokemon>, handler: @escaping (_: Pokemon) -> Void)
    func showSpeciesDetails(for pokemon: NamedResource<Pokemon>)
}

class PokemonListView: UIView {
    weak var delegate: PokemonListViewDelegate?

    private let collectionView: UICollectionView
    private let flowLayout = UICollectionViewFlowLayout()

    private var data: [NamedResource<Pokemon>] = []
    private let sizingCell = PokemonListCell(frame: .zero)

    private(set) var layout: PokemonListCell.LayoutType = .list {
        didSet {
            sizingCell.layout = layout
        }
    }

    init() {
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = Stylesheet.margin
        flowLayout.minimumLineSpacing = Stylesheet.margin
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(frame: .zero)

        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)

        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(resources: [NamedResource<Pokemon>]) {
        self.data = resources
        collectionView.reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        collectionView.pin.all()
    }

    func toggleLayout() {
        switch layout {
        case .list:
            layout = .grid
        case .grid:
            layout = .list
        }

        collectionView.performBatchUpdates(nil, completion: nil)
    }
}

extension PokemonListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonListCell.reuseIdentifier, for: indexPath) as! PokemonListCell
        cell.layout = layout
        cell.configure(resource: data[indexPath.item])
        delegate?.fetchDetails(for: data[indexPath.item], handler: { (pokemon) in
            cell.configure(pokemon: pokemon)
        })
        return cell
    }
}

extension PokemonListView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showSpeciesDetails(for: data[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        (collectionView.cellForItem(at: indexPath) as? PokemonListCell)?.layout = layout

        sizingCell.configure(resource: data[indexPath.item])
        let margin = Stylesheet.margin
        return sizingCell.sizeThatFits(CGSize(width: width - 2 * margin, height: .greatestFiniteMagnitude))
    }
}
