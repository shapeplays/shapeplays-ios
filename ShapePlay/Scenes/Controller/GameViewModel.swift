//
//  GameViewModel.swift
//  ShapePlay
//
//  Created by Frederik Christensen on 20/09/2018.
//  Copyright © 2018 fdc. All rights reserved.
//

import Foundation

class GameViewModel {

    let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func postAction(action: Action, isLongPress: Bool) {
        let move = Move(action: action.rawValue, isLongPress: isLongPress)
        let path = "/move"
        var request = URLRequest(url: URL(string: baseUrl + path)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(move)
        let session = URLSession.shared
        print("POST: \(baseUrl)")
        session.dataTask(with: request) { data, response, error in
            print(error?.localizedDescription)
        }.resume()
    }
}
