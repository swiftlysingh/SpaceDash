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
    var upcomingLaunch : UpcomingLaunchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkObject.delegate = self
        networkObject.fetchData(key: "launches/Upcoming")
        resizeForSmallScreen()
    }
    
    /// Making the Height of Upcoming Panel Dynamic
    func resizeForSmallScreen(){
        if UIScreen.main.bounds.height<896 {
            upcomingPanel.constant = UIScreen.main.bounds.height*0.045
            
            for panels in panelConstraints{
                panels.constant = UIScreen.main.bounds.height*0.03
            }
        }
    }
    
    func updateFromAPI(data: Any) {
        upcomingLaunch = (data as! UpcomingLaunchModel)
        DispatchQueue.main.async {
            print(self.upcomingLaunch!.decodedData?.launch_site.site_name)
        }
    }
    
    func error(error: Error) {
        print(error)
    }
}

