//
//  UINavigationController+statusBarStyle.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-06-07.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }

    open override var childViewControllerForStatusBarHidden: UIViewController? {
        return topViewController
    }
}
