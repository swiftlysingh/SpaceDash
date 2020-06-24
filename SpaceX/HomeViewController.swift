//
//  HomeViewController.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 24/06/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var UpcomingLaunch: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UpcomingLaunch.layer.cornerRadius = 40

    }

}
