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
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var launchSite: UILabel!
    @IBOutlet weak var payloadAndType: UILabel!
    @IBOutlet weak var isTentative: UILabel!
    @IBOutlet weak var rocketImage: UIImageView!
    
    let networkObject = NetworkManager(Constants.NetworkManager.baseURL)
    let upcomingLaunch = UpcomingLaunchModel()
    var senderView : String = ""
    
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
        
        adjustSize()
        
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
            print(launch.rocket.rocket_id)
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.SegueManager.detailViewSegue, sender: sender.titleLabel?.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? DetailsViewController {
            target.senderView = sender as! String
        }
    }
    
}

//MARK: - UI

extension HomeViewController: UIPopoverPresentationControllerDelegate {

    /// Making the Height of Upcoming Panel Dynamic
    func adjustSize(){
        if UIScreen.main.bounds.height<896 {
            upcomingPanel.constant = UIScreen.main.bounds.height*0.045
            
            for panels in panelConstraints{
                panels.constant = UIScreen.main.bounds.height*0.03
            }
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
        }
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

