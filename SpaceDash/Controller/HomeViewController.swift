//
//  HomeViewController.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 24/06/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,NetworkManagerDelegate {
    
    @IBOutlet weak var upcomingPanel: NSLayoutConstraint!
    @IBOutlet var panelConstraints: [NSLayoutConstraint]!
    
    var networkObject = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkObject.delegate = self
        if(UIScreen.main.bounds.height<896){
            resizeForSmallScreen()
        }
        networkObject.fetchData(demand: "launches/upcoming")
    }
    
    func updateData() {
        DispatchQueue.main.async {
            print(self.upcomingLaunch.getDate())
        }
    }
    
    /// Making the Height of Upcoming Panel Dynamic
    func resizeForSmallScreen(){
        upcomingPanel.constant = UIScreen.main.bounds.height*0.045
        
        for panels in panelConstraints{
            panels.constant = UIScreen.main.bounds.height*0.03
        }
    }
    
}
