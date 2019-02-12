//
//  Server.swift
//  ShapePlay
//
//  Created by Frederik Christensen on 20/09/2018.
//  Copyright © 2018 fdc. All rights reserved.
//

import UIKit

struct Server: Codable {
    let baseUrl: String
    let description: String

    init(baseUrl: String, description: String) {
        self.baseUrl = baseUrl
        self.description = description
    }
}
