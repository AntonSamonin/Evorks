//
//  SplashViewController.swift
//  Evorks
//
//  Created by Anton Samonin on 2/8/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.368627451, blue: 0.8901960784, alpha: 1)
        goToSignInScreen()
    }
    
    private func goToSignInScreen() {
        let vc = SignInViewController()
        var mainWindow: UIWindow? {
            if #available(iOS 13.0, *) {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    return windowScene.windows.first
                }
            }
            return UIApplication.shared.keyWindow
        }
        mainWindow?.rootViewController = SignUpViewController()
    }

}
