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
    func didPan(_ progress: CGFloat, state: UIGestureRecognizerState)
}

class PokemonListView: UIView {
    weak var delegate: PokemonListViewDelegate?

    private let headerHeight: CGFloat = 15

    private let headerShapeLayer = CAShapeLayer()
    private let header = UIView()
    let footer = PokemonListFooter()
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
        collectionView.contentInset = .vertical(headerHeight)
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)

        headerShapeLayer.fillColor = UIColor.pokedexRed.cgColor
        header.layer.insertSublayer(headerShapeLayer, at: 0)
        header.layer.shadowColor = UIColor.pokedexRed.cgColor
        header.layer.shadowOffset = CGSize(width: 0, height: 2)
        header.layer.shadowRadius = 2
        header.layer.shadowOpacity = 0.7
        addSubview(header)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        panGesture.maximumNumberOfTouches = 1
        footer.isUserInteractionEnabled = true
        footer.addGestureRecognizer(panGesture)
        addSubview(footer)

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
        header.pin.top().horizontally().height(headerHeight)
        headerShapeLayer.path = makeShapePath()
        footer.pin.bottom().horizontally().height(60)
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

    private func makeShapePath() -> CGPath {
        let path = CGMutablePath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: headerHeight))
        path.addLine(to: CGPoint(x: width * 0.3, y: headerHeight))
        path.addLine(to: CGPoint(x: width * 0.35, y: 5))
        path.addLine(to: CGPoint(x: width, y: 5))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.closeSubpath()
        return path
    }

    @objc private func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let progress = MenuHelper.progress(translationInView: translation, viewBounds: bounds, direction: .up)
        delegate?.didPan(progress, state: sender.state)
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
