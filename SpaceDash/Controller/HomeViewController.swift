//
//  HomeViewController.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 24/06/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var upcomingPanel: NSLayoutConstraint!
    @IBOutlet var panelConstraints: [NSLayoutConstraint]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UIScreen.main.bounds.height<896){
            resizeForSmallScreen()
        }
    }
    
    func resizeForSmallScreen(){
        upcomingPanel.constant = UIScreen.main.bounds.height*0.045
        
        for panels in panelConstraints{
            panels.constant = UIScreen.main.bounds.height*0.03
        }
    }
    
}
