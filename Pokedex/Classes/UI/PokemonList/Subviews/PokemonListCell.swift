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
    private let idLabel = UILabel()
    private var typeBadges: [TypeBadgeView] = []

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

        idLabel.textAlignment = .right
        addSubview(idLabel)
    }

    override func prepareForReuse() {
        clearBadges()
    }

    private func clearBadges() {
        for badge in typeBadges {
            badge.removeFromSuperview()
        }

        typeBadges.removeAll()
    }

    func configure(resource: NamedResource<Pokemon>) {
        self.nameLabel.text = resource.name.capitalized
        setNeedsLayout()
    }

    func configure(pokemon: Pokemon) {
        guard let imageUrl = pokemon.sprite.frontImageUrl else { return }
        imageView.loadImage(from: imageUrl)
        clearBadges()
        for type in pokemon.types {
            let badge = TypeBadgeView()
            badge.configure(pokemonType: type)
            typeBadges.append(badge)
            addSubview(badge)
        }

        let attributedString = NSMutableAttributedString(string: "#", attributes: [
            .font: UIFont.boldSystemFont(ofSize: Stylesheet.FontSize.header)
        ])
        attributedString.append(NSAttributedString(string: " \(pokemon.id)", attributes: [
            .font: UIFont.boldSystemFont(ofSize: Stylesheet.FontSize.body)
        ]))
        idLabel.attributedText = attributedString
        setNeedsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let actualWidth: CGFloat = layout == .list ? size.width : size.width * 0.3
        let actualHeight: CGFloat = layout == .list ? 90 : size.width * 0.3
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
        imageView.pin.left().vertically().width(height)
        nameLabel.pin.right(of: imageView).marginLeft(margin).size(nameSize).vCenter().marginBottom((nameSize.height + margin) / 2)
        for (index, badge) in typeBadges.enumerated() {
            badge.isHidden = false
            badge.pin.right(of: imageView).marginLeft(margin + CGFloat(index) * (margin + badge.width)).vCenter().marginTop((margin + badge.height) / 2)
        }

        idLabel.pin.right(margin).right(of: typeBadges.last ?? nameLabel).marginLeft(margin).vertically()
    }

    private func layoutGrid() {
        let margin = Stylesheet.margin
        let nameSize = nameLabel.sizeThatFits(CGSize(width: width - 2 * margin, height: height))
        nameLabel.pin.bottom(margin).size(nameSize).hCenter()
        imageView.pin.top(margin).above(of: nameLabel).marginBottom(margin).horizontally()
        typeBadges.forEach({ $0.isHidden = false })
    }
}
