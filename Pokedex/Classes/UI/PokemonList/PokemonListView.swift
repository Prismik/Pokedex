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
    init() {
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = Stylesheet.margin
        flowLayout.minimumLineSpacing = Stylesheet.margin
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(frame: .zero)

        addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonListView: UICollectionViewDataSource {
    
}
