//
//  RootFlowCoordinator.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-04-13.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import UIKit

class RootFlowCoordinator: BaseFlowCoordinator {
    private let mainViewController = PokemonListViewController()
    private let interactor = BottomMenuInteractor()
    private weak var bottomMenuViewController: BottomMenuViewController?

    init() {
        super.init()
        mainViewController.delegate = self
        mainViewController.interactor = interactor
        mainViewController.transitioningDelegate = self
        mainViewController.modalPresentationStyle = .custom
    }

    func start(in window: UIWindow) {
        window.rootViewController = UINavigationController(rootViewController: mainViewController)
    }
}

extension RootFlowCoordinator: PokemonListViewControllerDelegate {
    func pokemonListViewControllerDidPresentBottomMenu(_ listViewController: PokemonListViewController) {
        let menuViewController = BottomMenuViewController()
        bottomMenuViewController = menuViewController
        menuViewController.interactor = interactor
        menuViewController.delegate = self
        menuViewController.modalPresentationStyle = .custom
        menuViewController.modalPresentationCapturesStatusBarAppearance = true
        menuViewController.transitioningDelegate = self

        listViewController.present(menuViewController, animated: true, completion: nil)
    }

    func pokemonListViewController(_ listViewController: PokemonListViewController, didPresentDetail pokemon: Pokemon) {
        let viewController = PokemonDetailsViewController(pokemon: pokemon)
        listViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RootFlowCoordinator: BottomMenuViewControllerDelegate {
    func bottomMenuViewControllerDidDismiss(_ menuViewController: BottomMenuViewController) {
        mainViewController.dismiss(animated: true, completion: nil)
    }
}

extension RootFlowCoordinator: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomMenuAnimationController(style: .present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomMenuAnimationController(style: .dismiss)
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
