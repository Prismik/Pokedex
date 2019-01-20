//
//  BottomMenuViewController.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-01-20.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import UIKit

class BottomMenuViewController: UIViewController {
    var mainView: BottomMenuView {
        return view as! BottomMenuView
    }

    override func loadView() {
        let view = BottomMenuView()
        self.view = view
    }
}
