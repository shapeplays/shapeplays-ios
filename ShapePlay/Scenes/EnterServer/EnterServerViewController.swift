//
//  EnterServerViewController.swift
//  ShapePlay
//
//  Created by Frederik Christensen on 21/09/2018.
//  Copyright © 2018 fdc. All rights reserved.
//

import UIKit

class EnterServerViewController: UIViewController {
    let textField = Views.textField()
    let connectButton = Views.connectButton()
    let imageView = Views.imageView()

    let margin: CGFloat = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        defineLayout()
        setupTargets()
        textField.delegate = self
    }

    func setupTargets() {
        connectButton.addTarget(self, action: #selector(didTapConnect), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        view.addGestureRecognizer(tap)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @objc func didTapBackground(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    func defineLayout() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin * 3),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin * 3),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ])

        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: margin),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(connectButton)
        NSLayoutConstraint.activate([
            connectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            connectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            connectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectButton.topAnchor.constraint(equalTo: textField.safeAreaLayoutGuide.bottomAnchor, constant: margin),
            connectButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func navigateToGameController() {
        guard let ip = textField.text, ip.count > 0 else { return }
        let baseUrl = "http://\(ip):1337"
        let viewModel = GameViewModel(baseUrl: baseUrl)
        let vc = GameViewController(viewModel: viewModel)
        present(vc, animated: true, completion: nil)
    }

    @objc func didTapConnect(sender: UIButton) {
        navigateToGameController()
    }
}

extension EnterServerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigateToGameController()
        return true
    }
}

private enum Views {
    static func textField() -> UITextField {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.font = UIFont(name: "Copperplate", size: 30)
        field.returnKeyType = .join
        field.placeholder = "Enter IP Address"
        field.textAlignment = .center
        field.keyboardType = .numbersAndPunctuation
        return field
    }

    static func imageView() -> UIImageView {
        let image = UIImageView(image: #imageLiteral(resourceName: "shape_logo"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }

    static func connectButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Connect!", for: .normal)
        button.backgroundColor = Color.actionButton
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 30)
        return button
    }
}
