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
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var launchSite: UILabel!
    @IBOutlet weak var payloadAndType: UILabel!
    @IBOutlet weak var isTentative: UILabel!
    @IBOutlet weak var rocketImage: UIImageView!
    
    var networkObject = NetworkManager()
    var upcomingLaunch : UpcomingLaunchModel?
    var constants : Constants.HomeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkObject.delegate = self
        networkObject.fetchData(key: Constants.Networking.upcomingLaunchURL)
        adjustSize()
    }
    
    /// Making the Height of Upcoming Panel Dynamic
    func adjustSize(){
        if UIScreen.main.bounds.height<896 {
            upcomingPanel.constant = UIScreen.main.bounds.height*0.045
            
            for panels in panelConstraints{
                panels.constant = UIScreen.main.bounds.height*0.03
            }
        }
    }
    
    func error(error: Error) {
        print(error)
    }
    
    func updateFromAPI(data: Any) {
        DispatchQueue.main.async {
            
            self.upcomingLaunch = (data as! UpcomingLaunchModel)
    
            self.constants = Constants.HomeView(upcomingLaunch: self.upcomingLaunch!)
            
            self.updateUI()
        }
    }
    
    func updateUI(){
        
        launchSite.text = constants?.launchSite
        payloadAndType.text = constants?.payloadAndType
        launchDate.text =  upcomingLaunch?.getDate()
        
        self.isTentative.isHidden = !(self.upcomingLaunch?.decodedData!.is_tentative)!
        
        if(!(constants?.rocket=="Falcon 9")){
            rocketImage.image = UIImage(named: "f_heavy")
        }
    }
    
}

