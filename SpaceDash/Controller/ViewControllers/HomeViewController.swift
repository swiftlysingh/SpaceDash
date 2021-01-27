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
    @IBOutlet weak var missions: UILabel!
    @IBOutlet weak var watchNowButton: WatchNowButton!
    @IBOutlet weak var rocketImage: RocketImageView!
    @IBOutlet var launchProviderLogo: UIImageView!
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var weatherIcon: UIImageView!
    
    let networkObject = NetworkManager(Constants.NetworkManager.rocketLaunchLiveAPI)
    let cache = NSCache<NSString, DetailsViewModel>()
    
    var watchURL : URL? = nil
    
    let smallDeviceHeight: CGFloat = 896
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkObject.performRequest(key: Constants.HomeView.nextLaunch) { [weak self] (result: Result<NextLaunchData,Error>) in
            guard let self = self else { return }
            
            switch result {
            
            case .success(let nextLaunch):
                self.updateUI(nextLaunch)
                print(nextLaunch)
                break
                
            case .failure(let error):
                print(error)
            }
        }
        
        adjustUpcomingSize()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
                target.callAPI(withEndpoint: key, decode: [RocketData](), cachedData: cache)
                break
            case Constants.SegueManager.SenderValues.launches:
                target.callAPI(withEndpoint: key, decode: [LaunchesData](), cachedData: cache)
                break
            case Constants.SegueManager.SenderValues.launchSite:
                target.callAPI(withEndpoint: key, decode: [LaunchPadData](), cachedData: cache)
                break
            case Constants.SegueManager.SenderValues.ships:
                target.callAPI(withEndpoint: key, decode: [ShipsData](), cachedData: cache)
                break
            case Constants.SegueManager.SenderValues.capsules:
                target.callAPI(withEndpoint: key, decode: [CapsulesData](), cachedData: cache)
                break
            case Constants.SegueManager.SenderValues.landpads:
                target.callAPI(withEndpoint: key, decode: [LandpadsData](), cachedData: cache)
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
    func updateUI(_ upcomingLaunch : NextLaunchData){
        DispatchQueue.main.async {
            self.launchSite.text = upcomingLaunch.launchSite
            self.missions.text = upcomingLaunch.name
            self.launchDate.text =  upcomingLaunch.date
            self.launchProviderLogo.image = UIImage(named: upcomingLaunch.providerSlug)
            self.flagImage.image = UIImage(named: upcomingLaunch.countrySlug)
            self.rocketImage.image = UIImage(named: upcomingLaunch.vehicleSlug)
            
            if let weatherIconCode = upcomingLaunch.weatherIconCode {
                self.weatherIcon.image = UIImage(named: weatherIconCode)
            }
            
            if let media = upcomingLaunch.youtubeLink {
                self.watchNowButton.isHidden = false
                self.watchURL = media
            }
            
            self.adjustUpcomingSize()
        }
    }
}
