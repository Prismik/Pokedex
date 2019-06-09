//
//  StatsView.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-06-09.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import UIKit

struct StatViewData {
    let value: Int
    let name: String
    let color: UIColor
}

class StatsView: UIView {
    private let hexagon = CAShapeLayer()

    private var stats: [StatViewData] = []

    init() {
        super.init(frame: .zero)

        hexagon.fillColor = UIColor.white.cgColor
        layer.addSublayer(hexagon)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(stats: [StatViewData]) {
        self.stats = stats

        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        hexagon.path = roundedPolygonPath(rect: bounds, lineWidth: 2, sides: 6, cornerRadius: 5).cgPath
    }

    private func statsPath(rect: CGRect, lineWidth: CGFloat) -> CGPath {
        let path = UIBezierPath()
        // Map the stats into their respective locations if possible
//        let points = stats.map({})
        return path.cgPath
    }

    private func roundedPolygonPath(rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat, rotationOffset: CGFloat = 0) -> UIBezierPath {
        let path = UIBezierPath()
        let theta: CGFloat = CGFloat(2.0 * .pi) / CGFloat(sides) // How much to turn at every corner
        let offset: CGFloat = cornerRadius * tan(theta / 2.0)     // Offset from which to start rounding corners
        let width = min(rect.size.width, rect.size.height)        // Width of the square

        let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)

        // Radius of the circle that encircles the polygon
        // Notice that the radius is adjusted for the corners, that way the largest outer
        // dimension of the resulting shape is always exactly the width - linewidth
        let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0

        // Start drawing at a point, which by default is at the right hand edge
        // but can be offset
        var angle = CGFloat(rotationOffset)

        let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle),
                             y: center.y + (radius - cornerRadius) * sin(angle))
        path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta),
                              y: corner.y + cornerRadius * sin(angle + theta)))

        for _ in 0..<sides {
            angle += theta

            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle),
                                 y: center.y + (radius - cornerRadius) * sin(angle))
            let tip = CGPoint(x: center.x + radius * cos(angle),
                              y: center.y + radius * sin(angle))
            let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta),
                                y: corner.y + cornerRadius * sin(angle - theta))
            let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta),
                              y: corner.y + cornerRadius * sin(angle + theta))

            path.addLine(to: start)
            path.addQuadCurve(to: end, controlPoint: tip)
        }

        path.close()

        // Move the path to the correct origins
        let bounds = path.bounds
        let transform = CGAffineTransform(translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0,
                                          y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0)
        path.apply(transform)

        return path
    }
}
