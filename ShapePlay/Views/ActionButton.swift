//
//  ActionButton.swift
//  ShapePlay
//
//  Created by Frederik Christensen on 20/09/2018.
//  Copyright © 2018 fdc. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    let action: Action

    init(action: Action) {
        self.action = action
        super.init(frame: .zero)
        backgroundColor = Color.actionButton
        setTitle("\(action.rawValue)".uppercased(), for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 40)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
