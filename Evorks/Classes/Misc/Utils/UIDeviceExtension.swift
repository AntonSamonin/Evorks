//
//  UIDeviceExtension.swift
//  Evorks
//
//  Created by Anton Samonin on 1/31/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit

extension UIDevice {
    private static let maxHeightSmallDevice: CGFloat = 1334
    private static let maxHeightVerySmallDevice: CGFloat = 1136
    
    var isSmallScreen: Bool {
        return UIScreen.main.nativeBounds.height <= UIDevice.maxHeightSmallDevice
    }
    
    var isVerySmallScreen: Bool {
        return UIScreen.main.nativeBounds.height <= UIDevice.maxHeightVerySmallDevice
    }
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }

        return false
    }
    
    var hasBottomNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 > 20
        }

        return false
    }
}
