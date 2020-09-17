//
//  DetailCellImageView.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 06/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class DetailCellImageView: UIImageView {
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        self.layer.cornerRadius = 17
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.6
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
}
