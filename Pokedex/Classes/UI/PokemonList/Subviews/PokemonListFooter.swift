//
//  PokemonListFooter.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-01-19.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import UIKit

class PokemonListFooter: UIView {
    private let handle = UIView()
    private let shapeLayer = CAShapeLayer()

    init() {
        super.init(frame: .zero)

        tintColor = UIColor.pokedexRed

        handle.layer.cornerRadius = 2
        handle.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        addSubview(handle)

        shapeLayer.fillColor = tintColor.cgColor
        layer.insertSublayer(shapeLayer, at: 0)

        layer.shadowColor = UIColor.pokedexRed.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.7
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        shapeLayer.pin.all()
        shapeLayer.path = makeShapePath()

        handle.pin.top(Stylesheet.margin).hCenter().height(4).width(width * 0.32)
    }

    private func makeShapePath() -> CGPath {
        let lowerHeight: CGFloat = height * 0.4
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: lowerHeight))
        path.addLine(to: CGPoint(x: width * 0.1625, y: lowerHeight))
        path.addLine(to: CGPoint(x: width * 0.3125, y: 0))
        path.addLine(to: CGPoint(x: width * 0.6825, y: 0))
        path.addLine(to: CGPoint(x: width * 0.8375, y: lowerHeight))
        path.addLine(to: CGPoint(x: width, y: lowerHeight))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        return path
    }
}
