//
//  HomeViewController.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 24/06/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,NetworkManagerDelegate {
    
    @IBOutlet weak var upcomingView: UpcomingView!
    @IBOutlet weak var upcomingPanel: NSLayoutConstraint!
    @IBOutlet var panelConstraints: [NSLayoutConstraint]!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var launchSite: UILabel!
    @IBOutlet weak var payloadAndType: UILabel!
    @IBOutlet weak var watchNowButton: WatchNowButton!
    @IBOutlet weak var isTentative: UILabel!
    @IBOutlet weak var rocketImage: RocketImageView!
    
    var networkObject = NetworkManager()
    var upcomingLaunch : UpcomingLaunchModel?
    var constants : Constants.HomeView?
    var senderView : String = ""
    var watchURL : URL? = nil
    
    let smallDeviceHeight: CGFloat = 896
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkObject.delegate = self
        networkObject.fetchData(demand: Constants.NetworkManager.upcomingLaunchURL)
        
        //tap gesture for tentative label
        self.isTentative.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tentativeClicked(_:))))
        self.isTentative.isUserInteractionEnabled = true
    }
    
    /// Making the Height of Upcoming Panel and View Dynamic
    func adjustUpcomingSize() {
        if UIScreen.main.bounds.height<smallDeviceHeight || !watchNowButton.isHidden {
            upcomingPanel.constant = UIScreen.main.bounds.height*0.04
            
            for panels in panelConstraints{
                panels.constant = UIScreen.main.bounds.height*0.025
            }
        }
        
        if UIScreen.main.bounds.height<smallDeviceHeight && !watchNowButton.isHidden {
            upcomingView.setupSmallHeight()
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
        
        checkWatchButton()
        adjustUpcomingSize()
        
        self.isTentative.isHidden = !(self.upcomingLaunch?.decodedData!.is_tentative)!
        if(!(constants?.rocket=="Falcon 9")){
            rocketImage.image = UIImage(named: "f_heavy")
        }
    }
    
    /// This function will assign the video URL of the upcoming launch and display the "Watch Now" button if the URL available
    func checkWatchButton() {
        guard let safeWatchURL = upcomingLaunch?.decodedData?.links.video_link_url, UIApplication.shared.canOpenURL(safeWatchURL) else { return }
        self.watchURL = safeWatchURL
        watchNowButton.isHidden = false
    }
    
    
    @objc func tentativeClicked(_ sender: UITapGestureRecognizer){
        // we dont want to fill the popover to full width of the screen
        let standardWidth = self.view.frame.width - 60
        //to dynamically resize the popover, we premature-ly calculate the height of the label using the text content
        let estimatedHeight = Constants.HomeView.tentativeDetail.height(ConstrainedWidth: standardWidth - 24) //12 + 12 horizontal padding
        let tentativeDetailsVC = TentativeDetailsViewController()
        tentativeDetailsVC.lblTentativeDetail.text = Constants.HomeView.tentativeDetail
        tentativeDetailsVC.modalPresentationStyle = .popover //this tells that the presenting viewcontroller is an popover style
        tentativeDetailsVC.preferredContentSize = CGSize.init(width: standardWidth, height: estimatedHeight + 40) //40 is vertical padding
        tentativeDetailsVC.overrideUserInterfaceStyle = .light //disabling dark mode
        if let popoverPresentationController = tentativeDetailsVC.popoverPresentationController {
            //this option makes popover to preview below the "T" sign
            popoverPresentationController.permittedArrowDirections = .up
            //source view and source rect is used by popover controller to determine where the triangle should be placed and present the popover relative to the source view
            popoverPresentationController.sourceView = self.isTentative
            popoverPresentationController.sourceRect = self.isTentative.bounds
            popoverPresentationController.delegate = self
        }
        self.present(tentativeDetailsVC, animated: true, completion: nil)
    }
    
}


//MARK: - IBOutlets

extension HomeViewController {
    
    @IBAction func watchNowButton(_ sender: UIButton) {
        UIApplication.shared.open(watchURL!)
    }
    
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

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // .none makes the viewcontroller to be present as popover always, no matter what trait changes
        return .none
    }
    
}

