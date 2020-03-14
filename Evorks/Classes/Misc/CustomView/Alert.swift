//
//  Alert.swift
//  Evorks
//
//  Created by Anton Samonin on 3/11/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit

final class Alert {
    static func simple(title: String? = nil,
                       message: String? = nil,
                       firstButtonTitle: String? = nil,
                       firstButtonAction: (() -> ())? = nil,
                       cancelButtonTitle: String? = nil,
                       cancelButtonAction: (() -> ())? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let titleForFirstButton = firstButtonTitle {
            alert.addAction(UIAlertAction(title: titleForFirstButton, style: .default, handler: { _ in firstButtonAction?() }))
        }
        
        if let titleForCancelButton = cancelButtonTitle {
            alert.addAction(UIAlertAction(title: titleForCancelButton, style: .cancel, handler: { _ in cancelButtonAction?() }))
        }
        
        return alert
    }
}

