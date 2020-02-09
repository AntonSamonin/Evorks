//
//  File.swift
//  Evorks
//
//  Created by Anton Samonin on 2/8/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit

final class Font {
    class Montserrat {
        static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Regular", size: size)!
        }
        
        static func bold(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Bold", size: size)!
        }
        
        static func medium(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Medium", size: size)!
        }
        
        static func semibold(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-SemiBold", size: size)!
        }
        
        static func thin(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Thin", size: size)!
        }
        
        static func light(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Light", size: size)!
        }
    }
}
