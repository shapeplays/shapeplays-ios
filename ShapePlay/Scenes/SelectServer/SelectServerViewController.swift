//
//  SelectServerViewController.swift
//  ShapePlay
//
//  Created by Frederik Christensen on 20/09/2018.
//  Copyright © 2018 fdc. All rights reserved.
//

import UIKit

class SelectServerViewController: UIViewController {

    let servers: [Server] = [Server(baseUrl: "http://localhost:1337", description: "Localhost")]

    let tableView = Views.tableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        defineLayout()
        setupTargets()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    func defineLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func setupTargets() {
        //
    }
}

extension SelectServerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServerCell.identifier, for: indexPath) as! ServerCell
        let server = servers[indexPath.row]
        cell.configure(server: server)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servers.count
    }
}

extension SelectServerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let server = servers[indexPath.row]
        let viewModel = GameViewModel(baseUrl: server.baseUrl)
        let vc = GameViewController(viewModel: viewModel)
        present(vc, animated: true, completion: nil)
    }
}

private enum Views {
    static func tableView() -> UITableView {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ServerCell.self, forCellReuseIdentifier: ServerCell.identifier)
        return tableView
    }
}
