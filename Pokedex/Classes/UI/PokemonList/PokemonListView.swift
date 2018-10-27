//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class PokemonListView: UIView {
    private let collectionView: UICollectionView
    private let flowLayout = UICollectionViewFlowLayout()

    private var data: [String] = []
    private let sizingCell = PokemonListCell(frame: .zero)

    init() {
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = Stylesheet.margin
        flowLayout.minimumLineSpacing = Stylesheet.margin
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(frame: .zero)

        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(names: [String]) {
        self.data = names
        collectionView.reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        collectionView.pin.all()
    }
}

extension PokemonListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonListCell.reuseIdentifier, for: indexPath) as! PokemonListCell
        cell.configure(name: data[indexPath.item])
        return cell
    }
}

extension PokemonListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizingCell.configure(name: data[indexPath.item])
        let margin = Stylesheet.margin
        return sizingCell.sizeThatFits(CGSize(width: width - 2 * margin, height: .greatestFiniteMagnitude))
    }
}
