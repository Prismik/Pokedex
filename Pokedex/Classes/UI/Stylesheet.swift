//
//  Stylesheet.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class Stylesheet {
    static let margin: CGFloat = 10

    class FontSize {
        static let header: CGFloat = 26
        static let body: CGFloat = 16
        static let accessory: CGFloat = 14
        static let tiny: CGFloat = 12
    }
}

extension UIColor {
    convenience init(r red: Int, g green: Int, b blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
    }

    static var pokedexRed: UIColor {
        return UIColor(r: 227, g: 0, b: 39)
    }

    struct PokemonType {
        static var normal: UIColor {
            return UIColor(r: 155, g: 155, b: 135)
        }

        static var fire: UIColor {
            return UIColor(r: 245, g: 45, b: 30)
        }

        static var water: UIColor {
            return UIColor(r: 40, g: 130, b: 255)
        }

        static var electric: UIColor {
            return UIColor(r: 250, g: 195, b: 40)
        }

        static var grass: UIColor {
            return UIColor(r: 100, g: 195, b: 70)
        }

        static var ice: UIColor {
            return UIColor(r: 90, g: 190, b: 255)
        }

        static var fighting: UIColor {
            return UIColor(r: 170, g: 65, b: 55)
        }

        static var poison: UIColor {
            return UIColor(r: 150, g: 60, b: 135)
        }

        static var ground: UIColor {
            return UIColor(r: 210, g: 175, b: 70)
        }

        static var flying: UIColor {
            return UIColor(r: 115, g: 130, b: 255)
        }

        static var psychic: UIColor {
            return UIColor(r: 245, g: 55, b: 135)
        }

        static var bug: UIColor {
            return UIColor(r: 155, g: 175, b: 25)
        }

        static var rock: UIColor {
            return UIColor(r: 175, g: 155, b: 85)
        }

        static var ghost: UIColor {
            return UIColor(r: 85, g: 80, b: 170)
        }

        static var dragon: UIColor {
            return UIColor(r: 100, g: 75, b: 235)
        }

        static var dark: UIColor {
            return UIColor(r: 100, g: 65, b: 50)
        }

        static var steel: UIColor {
            return UIColor(r: 155, g: 155, b: 175)
        }

        static var fairy: UIColor {
            return UIColor(r: 230, g: 130, b: 235)
        }
    }

    struct DamageClass {
        static var special: UIColor {
            return UIColor(r: 81, g: 88, b: 110)
        }

        static var physical: UIColor {
            return UIColor(r: 185, g: 51, b: 35)
        }

        static var status: UIColor {
            return UIColor(r: 139, g: 136, b: 140)
        }
    }
}
