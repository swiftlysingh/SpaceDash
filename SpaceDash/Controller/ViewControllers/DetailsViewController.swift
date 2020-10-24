//
//  DetailsTableViewController.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 05/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
import Lottie

class DetailsViewController: UIViewController {
    
    var senderView : String = ""
//    var networkObject = NetworkManager(key: " ")
    var decodedData : DetailsViewModel?
    
    @IBOutlet var DetailTableView: UITableView!
    @IBOutlet var loadingAnimation: AnimationView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(named: Constants.Colors.DashCream)
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: Constants.Colors.DashBlack)
        
        loadingAnimationView()
        
        DetailTableView.dataSource = self
        DetailTableView.register(UINib(nibName: Constants.DetailsView.nibName, bundle: nil), forCellReuseIdentifier: Constants.DetailsView.reuseId)
        
//        networkObject.delegate = self
//        networkObject.fetchData(demand: senderView)
    }
    
    /// Add loading Animation before the Details View. The type of animation is in Interface Builder
    func loadingAnimationView(){
        loadingAnimation.backgroundColor = .black
        loadingAnimation.contentMode = .scaleAspectFit
        loadingAnimation.loopMode = .loop
        loadingAnimation.play()
    }
}

//MARK: - Network Manager

extension DetailsViewController {
    
    func updateFromAPI(data: Any) {
        DispatchQueue.main.async {
            self.decodedData = (data as! DetailsViewModel)
            self.loadingAnimation.stop()
            self.loadingAnimation.removeFromSuperview()
            self.DetailTableView.reloadData()
        }
    }
    
    func error(error: Error) {
        print(error)
    }
    
}


// MARK: - Table view data source

extension DetailsViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decodedData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.navigationController?.setNavigationBarHidden(false, animated: false) //Enable Navigation Bar
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DetailsView.reuseId, for: indexPath) as! DetailsTableViewCell
        
        cell.title.text = decodedData?.title[indexPath.row]
        cell.details.text = decodedData?.details[indexPath.row]
        if !(decodedData?.image.isEmpty)! {
            cell.photo.downloadImage(from: (decodedData?.image[indexPath.row])!)
        }
        if !(decodedData?.subTitle.isEmpty)!{
            cell.subTitle.text = decodedData?.subTitle[indexPath.row]
        }
        cell.isActive.isHidden = !decodedData!.isActive[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame:CGRect (x: 0, y: 0, width: 320, height: 20) ) as UIView
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame:CGRect (x: 0, y: 0, width: 320, height: 20) ) as UIView
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}


