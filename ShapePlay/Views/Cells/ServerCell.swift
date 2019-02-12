//
//  ServerCell.swift
//  ShapePlay
//
//  Created by Frederik Christensen on 20/09/2018.
//  Copyright © 2018 fdc. All rights reserved.
//

import UIKit

class ServerCell: UITableViewCell {
    static let identifier = "ServerCell"

    func configure(server: Server) {
        textLabel?.text = server.description
        detailTextLabel?.text = server.baseUrl
    }
}
