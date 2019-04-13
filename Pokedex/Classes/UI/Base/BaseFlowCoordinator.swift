//
//  BaseFlowCoordinator.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-04-13.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import Foundation

import UIKit

class BaseFlowCoordinator: NSObject {
    let id = UUID().uuidString

    weak var presentingViewController: UIViewController?
    weak var parentFlowCoordinator: BaseFlowCoordinator?

    private var childCoordinators: [BaseFlowCoordinator] = []

    init(presentingViewController: UIViewController? = nil) {
        self.presentingViewController = presentingViewController
    }

    func addChildFlowCoordinator(_ coordinator: BaseFlowCoordinator) {
        coordinator.parentFlowCoordinator = self
        childCoordinators.append(coordinator)
    }

    func removeFromParentFlowCoordinator() {
        parentFlowCoordinator?.removeFlowCoordinator(self)
    }

    func removeFlowCoordinator(_ coordinator: BaseFlowCoordinator) {
        guard let index = childCoordinators.index(where: { $0.id == coordinator.id }) else { return }
        childCoordinators.remove(at: index)
    }
}
