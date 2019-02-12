//
//  GameViewController.swift
//  ShapePlay
//
//  Created by Frederik Christensen on 20/09/2018.
//  Copyright © 2018 fdc. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    let arrowInputView = Views.arrowInputView()
    let aButton = Views.aButton()
    let bButton = Views.bButton()
    let imageView = Views.imageView()
    let selectButton = Views.selectButton()
    let startButton = Views.startButton()
    let feedback = UIImpactFeedbackGenerator()

    let viewModel: GameViewModel

    let buttonSize: CGFloat = 70

    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        defineLayout()
        setupTargets()
        arrowInputView.delegate = self
        feedback.prepare()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    func defineLayout() {
        view.addSubview(arrowInputView)
        NSLayoutConstraint.activate([
            arrowInputView.widthAnchor.constraint(equalToConstant: 200),
            arrowInputView.heightAnchor.constraint(equalToConstant: 200),
            arrowInputView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arrowInputView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])

        aButton.layer.cornerRadius = buttonSize / 2
        view.addSubview(aButton)
        NSLayoutConstraint.activate([
            aButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            aButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            aButton.widthAnchor.constraint(equalToConstant: buttonSize),
            aButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])

        bButton.layer.cornerRadius = buttonSize / 2
        view.addSubview(bButton)
        NSLayoutConstraint.activate([
            bButton.trailingAnchor.constraint(equalTo: aButton.leadingAnchor, constant: -24),
            bButton.centerYAnchor.constraint(equalTo: aButton.centerYAnchor, constant: 20),
            bButton.widthAnchor.constraint(equalToConstant: buttonSize),
            bButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])

        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(selectButton)
        NSLayoutConstraint.activate([
            selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])

        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -8),
        ])
    }

    func setupTargets() {
        bButton.addTarget(self, action: #selector(didTapBButton), for: .touchDown)
        selectButton.addTarget(self, action: #selector(didTapSelectButton), for: .touchDown)
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchDown)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAButton))
        aButton.addGestureRecognizer(tap)

        let press = UILongPressGestureRecognizer(target: self, action: #selector(didTapLongAButton))
        press.minimumPressDuration = 0.15
        aButton.addGestureRecognizer(press)
    }

    func nextAction(action: Action, isLongPress: Bool = false) {
        print("Action: \(action), isLongPress: \(isLongPress)")
        feedback.impactOccurred()
        viewModel.postAction(action: action, isLongPress: isLongPress)
    }

    @objc func didTapAButton(sender: UITapGestureRecognizer) {
        nextAction(action: .a)
    }

    @objc func didTapLongAButton(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            nextAction(action: .a, isLongPress: true)
        }
    }

    @objc func didTapBButton(sender: UIButton) {
        nextAction(action: .b)
    }

    @objc func didTapSelectButton(sender: UIButton) {
        nextAction(action: .select)
    }

    @objc func didTapStartButton(sender: UIButton) {
        nextAction(action: .start)
    }
}

private enum Views {
    static func arrowInputView() -> ArrowInputView {
        let view = ArrowInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.80
        return view
    }

    static func aButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.actionButton
        button.setTitle("A", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 40)
        return button
    }

    static func bButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.actionButton
        button.setTitle("B", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 40)
        return button
    }

    static func imageView() -> UIImageView {
        let image = UIImageView(image: #imageLiteral(resourceName: "shape_logo"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }

    static func selectButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select", for: .normal)
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 25)
        button.tintColor = .black
        return button
    }

    static func startButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 25)
        button.tintColor = .black
        return button
    }
}

extension GameViewController: ArrowInputViewDelegate {
    func didSelectAction(action: Action) {
        nextAction(action: action)
    }
}
