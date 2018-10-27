//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import PinLayout

class PokemonListCell: UICollectionViewCell {
    static let reuseIdentifier = "PokemonListCellReuseIdentifier"

    private let nameLabel = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(nameLabel)
    }

    func configure(resource: NamedResource) {
        self.nameLabel.text = resource.name
        setNeedsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let margin = Stylesheet.margin
        let nameLabelSize = nameLabel.sizeThatFits(CGSize(width: size.width - 2 * margin, height: size.height))

        return CGSize(width: size.width, height: nameLabelSize.height + 2 * margin)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let margin = Stylesheet.margin
        let nameSize = nameLabel.sizeThatFits(CGSize(width: width - 2 * margin, height: height))
        nameLabel.pin.left(margin).size(nameSize).vCenter()
    }
}
