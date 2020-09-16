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
    var senderView : String = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkObject.delegate = self
        networkObject.fetchData(demand: Constants.NetworkManager.upcomingLaunchURL)
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// This will print error in network call
    /// - Parameter error: error
    func error(error: Error) {
        print(error)
    }
    
    
    /// This will bring decoded and cleaned data from the Network Manger
    /// - Parameter data: data
    func updateFromAPI(data: Any) {
        DispatchQueue.main.async {
            
            self.upcomingLaunch = (data as! UpcomingLaunchModel)
    
            self.constants = Constants.HomeView(upcomingLaunch: self.upcomingLaunch!)
            
            self.updateUI()
        }
    }
    
    /// This function will update the UI once updateFromAPI updates the data for HomeViewController
    
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


//MARK: - IBOutlets

extension HomeViewController {
    
    @IBAction func rocketsButton(_ sender: UIButton) {
        senderView = Constants.SegueManager.SenderValues.rocket
        performSegue(withIdentifier: Constants.SegueManager.detailViewSegue, sender: self)
    }
    
    @IBAction func launchSitesButton(_ sender: UIButton) {
        senderView = Constants.SegueManager.SenderValues.launchSite
        performSegue(withIdentifier: Constants.SegueManager.detailViewSegue, sender: self)
    }
    @IBAction func landpadsButton(_ sender: UIButton) {
        senderView = Constants.SegueManager.SenderValues.landpads
        performSegue(withIdentifier: Constants.SegueManager.detailViewSegue, sender: self)
    }
    @IBAction func capsulesButton(_ sender: UIButton) {
        senderView = Constants.SegueManager.SenderValues.capsules
        performSegue(withIdentifier: Constants.SegueManager.detailViewSegue, sender: self)
    }
    @IBAction func shipsButton(_ sender: UIButton) {
        senderView = Constants.SegueManager.SenderValues.ships
        performSegue(withIdentifier: Constants.SegueManager.detailViewSegue, sender: self)
    }
    @IBAction func launchesButton(_ sender: UIButton) {
       senderView = Constants.SegueManager.SenderValues.launches
        performSegue(withIdentifier: Constants.SegueManager.detailViewSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? DetailsViewController {
            target.senderView = senderView
        }
    }
}

