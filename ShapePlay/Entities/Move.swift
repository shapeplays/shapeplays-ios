//
//  Move.swift
//  ShapePlay
//
//  Created by Frederik Christensen on 20/09/2018.
//  Copyright © 2018 fdc. All rights reserved.
//

import Foundation

struct Move: Codable {
    let action: Int
    let isLongPress: Bool
}

enum Action: Int {
    case up = 1
    case down = 2
    case right = 3
    case left = 4
    case a = 5
    case b = 6
    case select = 7
    case start = 8
    case unknown
}
