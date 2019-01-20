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

        fromViewController.view.isHidden = true
        toViewController.view.frame = UIScreen.main.bounds

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {

        }, completion: { _ in
            fromViewController.view.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func dismiss(from fromViewController: UIViewController, to toViewController: UIViewController, using transitionContext: UIViewControllerContextTransitioning) {
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {

        }, completion: { _ in
            let didTransitionComplete = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(didTransitionComplete)
        })
    }
}
