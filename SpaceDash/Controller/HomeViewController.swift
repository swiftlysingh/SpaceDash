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
    
    var networkObject = NetworkManager()
    var upcomingLaunch : UpcomingLaunchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkObject.delegate = self
        networkObject.fetchData(key: "launches/Upcoming")
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
    
    func updateFromAPI(data: Any) {
        DispatchQueue.main.async {
            self.upcomingLaunch = (data as! UpcomingLaunchModel)
            self.launchSite.text = self.upcomingLaunch?.decodedData?.launch_site.site_name ?? "Launch Site Not Declared"
            self.payloadAndType.text = "\(self.upcomingLaunch?.decodedData?.rocket.second_stage.payloads[0].payload_id ?? "NA"), \(self.upcomingLaunch?.decodedData?.rocket.second_stage.payloads[0].payload_type ?? "NA")"
//            self.launchDate.text = "\(NSDate(timeIntervalSince1970: (self.upcomingLaunch?.decodedData!.launch_date_local)!))"
            print(self.upcomingLaunch?.decodedData?.launch_date_local)
        }
    }
    
    func error(error: Error) {
        print(error)
    }
}

