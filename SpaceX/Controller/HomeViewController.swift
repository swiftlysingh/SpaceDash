//
//  HomeViewController.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 24/06/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var upcomingLaunchHeight: NSLayoutConstraint!
    @IBOutlet weak var upcomingPanel: NSLayoutConstraint!
    @IBOutlet var panelConstraints: [NSLayoutConstraint]!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingLaunchHeight.constant = UIScreen.main.bounds.height*0.55
        if(UIScreen.main.bounds.height<896){
            updateUIConstraints()
        }

    }
    func updateUIConstraints(){
                upcomingPanel.constant = UIScreen.main.bounds.height*0.045
                
                for panels in panelConstraints{
                    panels.constant = UIScreen.main.bounds.height*0.03
                }
    }
}
