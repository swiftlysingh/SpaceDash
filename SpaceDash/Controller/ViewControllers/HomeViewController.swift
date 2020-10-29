//
//  HomeViewController.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 24/06/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var upcomingView: UpcomingView!
    @IBOutlet weak var upcomingPanel: NSLayoutConstraint!
    @IBOutlet var panelConstraints: [NSLayoutConstraint]!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var launchSite: UILabel!
    @IBOutlet weak var payloadAndType: UILabel!
    @IBOutlet weak var watchNowButton: WatchNowButton!
    @IBOutlet weak var isTentative: UILabel!
    @IBOutlet weak var rocketImage: RocketImageView!
    
    let networkObject = NetworkManager(Constants.NetworkManager.baseURL)
    let upcomingLaunch = UpcomingLaunchModel()
    
    var watchURL : URL? = nil
    
    let smallDeviceHeight: CGFloat = 896
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkObject.performRequest(key: Constants.NetworkManager.upcomingLaunchURL) { [weak self] (result: Result<[UpcomingLaunchData],Error>) in
            guard let self = self else { return }
            
            switch result {
            
            case .success(let launches):
                let launch = self.upcomingLaunch.cleanData(launches)
                self.updateModel(launch)
                self.updateUI()
                break
                
            case .failure(let error):
                print(error)
            }
        }
        
        adjustUpcomingSize()
        
        //tap gesture for tentative label
        self.isTentative.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tentativeClicked(_:))))
        self.isTentative.isUserInteractionEnabled = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// Update the model with new data that has just arrived from API
    func updateModel(_ launch : UpcomingLaunchData){
        
        self.upcomingLaunch.launchSite = launch.launch_site.site_name_long
        self.upcomingLaunch.payloadAndType = "\(launch.rocket.second_stage.payloads[0].payload_id), \(launch.rocket.second_stage.payloads[0].payload_type)"
        self.upcomingLaunch.launchDate = launch.launch_date_unix.getDate()
        self.upcomingLaunch.isTentative = launch.is_tentative
        self.upcomingLaunch.rocket = launch.rocket.rocket_id
        self.upcomingLaunch.watchNow = launch.links.video_link_url
        
        print(launch.rocket.rocket_id)
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.SegueManager.detailViewSegue, sender: sender.titleLabel?.text)
    }
    
    @IBAction func watchNowButton(_ sender: UIButton) {
        UIApplication.shared.open(watchURL!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? DetailsViewController {
            let key = sender as! String
            print("Sender: \(key)")
            
            switch key {
            case Constants.SegueManager.SenderValues.rocket:
                target.callAPI(withEndpoint: key, decode: [RocketData]())
                break
            case Constants.SegueManager.SenderValues.launches:
                target.callAPI(withEndpoint: key, decode: [LaunchesData]())
                break
            case Constants.SegueManager.SenderValues.launchSite:
                target.callAPI(withEndpoint: key, decode: [LaunchPadData]())
                break
            case Constants.SegueManager.SenderValues.ships:
                target.callAPI(withEndpoint: key, decode: [ShipsData]())
                break
            case Constants.SegueManager.SenderValues.capsules:
                target.callAPI(withEndpoint: key, decode: [CapsulesData]())
                break
            case Constants.SegueManager.SenderValues.landpads:
                target.callAPI(withEndpoint: key, decode: [LandpadsData]())
                break
            default:
                print("error")
            }
        }
    }
    
}

//MARK: - UI

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
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
    
    /// This function will update the UI once updateFromAPI updates the data for HomeViewController
    func updateUI(){
        DispatchQueue.main.async {
            self.launchSite.text = self.upcomingLaunch.launchSite
            self.payloadAndType.text = self.upcomingLaunch.payloadAndType
            self.launchDate.text =  self.upcomingLaunch.launchDate
            self.isTentative.isHidden = !(self.upcomingLaunch.isTentative!)
            self.rocketImage.image = UIImage(named: self.upcomingLaunch.rocket!)
            self.checkWatchButton()
            self.adjustUpcomingSize()
        }
    }
    
    /// This function will assign the video URL of the upcoming launch and display the "Watch Now" button if the URL available
    func checkWatchButton() {
        guard let safeWatchURL = upcomingLaunch.watchNow, UIApplication.shared.canOpenURL(safeWatchURL) else { return }
        self.watchURL = safeWatchURL
        watchNowButton.isHidden = false
    }
    
    
    @objc func tentativeClicked(_ sender: UITapGestureRecognizer){
        // we dont want to fill the popover to full width of the screen
        let standardWidth = self.view.frame.width - 60
        
        //to dynamically resize the popover, we premature-ly calculate the height of the label using the text content
        let estimatedHeight = Constants.HomeView.tentativeDetail.height(ConstrainedWidth: standardWidth - 24)
        
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
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // .none makes the viewcontroller to be present as popover always, no matter what trait changes
        return .none
    }
    
}
