//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import PinLayout

class PokemonListCell: UICollectionViewCell {
    enum LayoutType {
        case list
        case grid

        var title: String {
            switch self {
            case .list:
                return "List"
            case .grid:
                return "Grid"
            }
        }
    }

    static let reuseIdentifier = "PokemonListCellReuseIdentifier"

    private let nameLabel = UILabel()
    private let imageView = UIImageView()

    var layout: LayoutType = .list {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        nameLabel.minimumScaleFactor = 0.7
        nameLabel.adjustsFontSizeToFitWidth = true
        addSubview(nameLabel)

        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }

    func configure(resource: NamedResource<Pokemon>) {
        self.nameLabel.text = resource.name.capitalized
        setNeedsLayout()
    }

    func configure(pokemon: Pokemon) {
        guard let imageUrl = pokemon.sprite.frontImageUrl else { return }
        imageView.loadImage(from: imageUrl)
        setNeedsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let actualWidth: CGFloat = layout == .list ? size.width : 120
        let actualHeight: CGFloat = layout == .list ? 80 : 120
        return CGSize(width: actualWidth, height: actualHeight)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        switch layout {
        case .list:
            layoutList()
        case .grid:
            layoutGrid()
        }
    }

    private func layoutList() {
        let margin = Stylesheet.margin
        let nameSize = nameLabel.sizeThatFits(CGSize(width: width - 2 * margin, height: height))
        nameLabel.pin.right(of: imageView).marginLeft(margin).size(nameSize).vCenter()
        imageView.pin.left().vertically().width(height)
    }

    private func layoutGrid() {
        let margin = Stylesheet.margin
        let nameSize = nameLabel.sizeThatFits(CGSize(width: width - 2 * margin, height: height))
        nameLabel.pin.bottom(margin).size(nameSize)
        imageView.pin.top(margin).above(of: nameLabel).marginBottom(margin).horizontally()

    }
}
