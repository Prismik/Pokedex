//
//  BottomMenuAnimationController.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-01-20.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import UIKit

class BottomMenuAnimationController: NSObject {
    private let style: PresentationStyle
    private let baseTransitionDuration: TimeInterval = 0.25

    // To dismiss from the tap gesture
    private weak var transitionContext: UIViewControllerContextTransitioning?
    private weak var fromVC: UIViewController?
    private weak var toVC: UIViewController?

    enum PresentationStyle {
        case present
        case dismiss
    }

    init(style: PresentationStyle) {
        self.style = style
    }
}

extension BottomMenuAnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if let transitionContext = transitionContext {
            return transitionContext.isInteractive ? baseTransitionDuration * 1.5 : baseTransitionDuration
        }

        return baseTransitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }

        self.fromVC = fromViewController
        self.toVC = toViewController
        self.transitionContext = transitionContext

        switch style {
        case .present:
            present(from: fromViewController, to: toViewController, using: transitionContext)
        case .dismiss:
            dismiss(from: fromViewController, to: toViewController, using: transitionContext)
        }
    }

    private func present(from fromViewController: UIViewController, to toViewController: UIViewController, using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        guard let navigationViewController = fromViewController as? UINavigationController else { return }
        guard let listViewController = navigationViewController.topViewController as? PokemonListViewController else { return }
        guard let menuViewController = toViewController as? BottomMenuViewController else { return }

        let targetYPosition = listViewController.mainView.maxY * MenuHelper.menuWidth
        let footerView = listViewController.mainView.footer
        let menuContentView = menuViewController.mainView

        menuContentView.pin.below(of: footerView).marginTop(-footerView.height).height(footerView.height)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            footerView.pin.bottom(targetYPosition)
            let menuHeight: CGFloat = listViewController.view.height - footerView.minY
            menuViewController.view.pin.horizontally().bottom().height(menuHeight)
            menuContentView.pin.bottom().horizontally().height(menuHeight)
        }, completion: { _ in
            let didCompleteTransition = !transitionContext.transitionWasCancelled
            listViewController.mainView.footer.isHidden = didCompleteTransition
            transitionContext.completeTransition(didCompleteTransition)
        })
    }

    private func dismiss(from fromViewController: UIViewController, to toViewController: UIViewController, using transitionContext: UIViewControllerContextTransitioning) {
        guard let navigationViewController = toViewController as? UINavigationController else { return }
        guard let listViewController = navigationViewController.topViewController as? PokemonListViewController else { return }
        guard let menuViewController = fromViewController as? BottomMenuViewController else { return }

        let footerView = listViewController.mainView.footer
        let menuContentView = menuViewController.mainView
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            footerView.pin.bottom(0)
            menuContentView.pin.below(of: footerView).marginTop(-footerView.height)
        }, completion: { _ in
            let didCompleteTransition = !transitionContext.transitionWasCancelled
            listViewController.mainView.footer.isHidden = !didCompleteTransition
            transitionContext.completeTransition(didCompleteTransition)
        })
    }
}
