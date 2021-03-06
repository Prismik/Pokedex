//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-26.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let bootstrapper = Bootstrapper()
    private let rootFlowCoordinator = RootFlowCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        bootstrapper.bootstrap()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        bootstrapper.configure(window: window)
        rootFlowCoordinator.start(in: window)

        return true
    }
}

