//
//  ArrowInputView.swift
//  ShapePlay
//
//  Created by Frederik Christensen on 20/09/2018.
//  Copyright © 2018 fdc. All rights reserved.
//

import UIKit

protocol ArrowInputViewDelegate: class {
    func didSelectAction(action: Action)
}

class ArrowInputView: UIView {
    weak var delegate: ArrowInputViewDelegate?
    let upButton = Views.button(action: .up)
    let downButton = Views.button(action: .down)
    let rightButton = Views.button(action: .right)
    let leftButton = Views.button(action: .left)

    init() {
        super.init(frame: .zero)
        defineLayout()
        setupTargets()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func defineLayout() {
        addSubview(upButton)
        NSLayoutConstraint.activate([
            upButton.topAnchor.constraint(equalTo: topAnchor),
            upButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            upButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
            upButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33),
        ])

        addSubview(downButton)
        NSLayoutConstraint.activate([
            downButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            downButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            downButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
            downButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33),
        ])

        addSubview(rightButton)
        NSLayoutConstraint.activate([
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
            rightButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33),
        ])

        addSubview(leftButton)
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
            leftButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33),
        ])
    }

    func setupTargets() {
        upButton.addTarget(self, action: #selector(didSelectAction), for: .touchDown)
        downButton.addTarget(self, action: #selector(didSelectAction), for: .touchDown)
        rightButton.addTarget(self, action: #selector(didSelectAction), for: .touchDown)
        leftButton.addTarget(self, action: #selector(didSelectAction), for: .touchDown)
    }

    @objc func didSelectAction(sender: UIButton) {
        guard let action = Action(rawValue: sender.tag) else { return }
        delegate?.didSelectAction(action: action)
    }
}

private enum Views {
    static func button(action: Action) -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = action.rawValue
        button.setImage(#imageLiteral(resourceName: "arrow_icon"), for: .normal)
        switch action {
        case .down:
            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        case .left:
            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 1.5)
        case .right:
            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 0.5)
        default:
            break
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
