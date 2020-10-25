//
//  WatchNowButtonView.swift
//  SpaceX
//
//  Created by Julian Kreller on 22/10/20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import UIKit

final class WatchNowButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Is hidden by default
        self.isHidden = true

        //Adding Shadow
        self.layer.applySketchShadow(
            color: .black,
            alpha: 0.2,
            x: 0,
            y: 0,
            blur: 50,
            spread: 9)
        self.layer.cornerRadius = 15
    }

}
