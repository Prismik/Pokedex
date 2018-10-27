//
//  UIView+geometry.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

extension UIView {
    var width: CGFloat {
        return bounds.width
    }

    var height: CGFloat {
        return bounds.height
    }

    var size: CGSize {
        return bounds.size
    }

    var origin: CGPoint {
        return frame.origin
    }

    var xPosition: CGFloat {
        return frame.origin.x
    }

    var yPosition: CGFloat {
        return frame.origin.y
    }

    var maxX: CGFloat {
        return frame.maxX
    }

    var maxY: CGFloat {
        return frame.maxY
    }

    var minX: CGFloat {
        return frame.minX
    }

    var minY: CGFloat {
        return frame.minY
    }

    var midX: CGFloat {
        return frame.midX
    }

    var midY: CGFloat {
        return frame.midY
    }
}
