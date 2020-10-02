//
//  String + Extension.swift
//  SpaceDash
//
//  Created by Waseem Akram on 02/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit



extension String {
    
    func height(ConstrainedWidth width: CGFloat) -> CGFloat {
        let label = UILabel()
        label.text = self
        label.numberOfLines = 0
        let estimatedSize = label.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        return estimatedSize.height
    }
    
}
