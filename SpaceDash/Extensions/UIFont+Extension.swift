//
//  UIFont+Extension.swift
//  SpaceDash
//
//  Created by akhigbe benjamin on 15/12/2020.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

extension UIFont{
    static func lora(_ type: Constants.Font.FontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "\(Constants.Font.lora)\(type.rawValue)", size: size)!
    }
    
    static func playFairDisplay(_ type: Constants.Font.FontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "\(Constants.Font.playFairDisplay)\(type.rawValue)", size: size)!
    }
    
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
}



