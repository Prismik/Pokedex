//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class PokemonListCell: UICollectionViewCell {
    private let name = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)


    }

    func configure(name: String) {
        self.name = name
        setNeedsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        
    }
}
