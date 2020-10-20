//
//  RocketImageView.swift
//  SpaceDash
//
//  Created by Maria Pankova on 18.10.2020.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

final class RocketImageView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Adding Shadow
        self.clipsToBounds = false
        self.layer.applySketchShadow(
          color: .black,
          alpha: 0.2,
          x: 2,
          y: 0,
          blur: 50,
          spread: -9)
        self.layer.cornerRadius = 35
    }
}

