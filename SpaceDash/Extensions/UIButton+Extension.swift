//
//  UIButton+Extension.swift
//  SpaceDash
//
//  Created by akhigbe benjamin on 15/12/2020.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String){
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}


