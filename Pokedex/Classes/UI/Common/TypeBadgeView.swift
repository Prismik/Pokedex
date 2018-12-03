//
//  TypeBadgeView.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-12-03.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class TypeBadgeView: UIView {
    private let label = UILabel()
    init() {
        super.init(frame: .zero)

        label.font = UIFont.systemFont(ofSize: Stylesheet.FontSize.accessory)
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 1, height: 1)
        label.textAlignment = .center
        addSubview(label)

        frame.size.width = 70
        frame.size.height = 24
        layer.cornerRadius = 12
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(pokemonType: PokemonType) {
        backgroundColor = pokemonType.color
        label.text = pokemonType.type.name.uppercased()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        label.pin.all()
    }
}
