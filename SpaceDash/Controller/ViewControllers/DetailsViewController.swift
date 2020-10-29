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
    
    let networkObject = NetworkManager(Constants.NetworkManager.baseURL)
    let detailsModel = DetailsViewModel()
    
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
        
    }
    
    func callAPI<T:Decodable>(withEndpoint senderView : String,decode model : T){
        
        networkObject.performRequest(key: senderView) { [weak self] (result: Result<T,Error>) in
            guard let self = self else { return }
            
            switch result {
            
            case .success(let launches):
                DispatchQueue.main.async {
                    self.detailsModel.fillData(model: launches, key: senderView)
                    self.updateUI()
                }
                
                
                break
                
            case .failure(let error):
                print(error)
            }
        }
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
    
    func updateUI() {
        DispatchQueue.main.async {
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
        return detailsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.navigationController?.setNavigationBarHidden(false, animated: false) //Enable Navigation Bar
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DetailsView.reuseId, for: indexPath) as! DetailsTableViewCell
        
        cell.title.text = detailsModel.title[indexPath.row]
        cell.details.text = detailsModel.details[indexPath.row]
        if !(detailsModel.image.isEmpty) {
            cell.photo.downloadImage(from: (detailsModel.image[indexPath.row]))
        }
        if !(detailsModel.subTitle.isEmpty){
            cell.subTitle.text = detailsModel.subTitle[indexPath.row]
        }
        cell.isActive.isHidden = !detailsModel.isActive[indexPath.row]
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


