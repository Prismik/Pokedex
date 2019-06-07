//
//  BottomMenuView.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2019-01-20.
//  Copyright © 2019 Francis Beauchamp. All rights reserved.
//

import UIKit

protocol BottomMenuViewDelegate: class {
    func didPan(_ progress: CGFloat, state: UIGestureRecognizerState)
}

class BottomMenuView: UIView {
    weak var delegate: BottomMenuViewDelegate?

    private let handleView = PokemonListFooter()
    private let actionsContainer = UIView()

    init() {
        super.init(frame: .zero)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        panGesture.maximumNumberOfTouches = 1
        handleView.isUserInteractionEnabled = true
        handleView.addGestureRecognizer(panGesture)
        addSubview(handleView)

        actionsContainer.backgroundColor = handleView.tintColor
        addSubview(actionsContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        handleView.pin.top().horizontally().height(60)
        actionsContainer.pin.below(of: handleView).horizontally().bottom()
    }

    @objc private func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let progress = MenuHelper.progress(translationInView: translation, viewBounds: bounds, direction: .down)
        delegate?.didPan(progress, state: sender.state)
    }
}
