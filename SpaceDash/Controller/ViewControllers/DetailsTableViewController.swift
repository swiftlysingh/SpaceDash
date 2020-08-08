//
//  DetailsTableViewController.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 05/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController,NetworkManagerDelegate {
    
    var senderView : String = ""
    var networkObject = NetworkManager()
    
    var decodedData : DetailsViewModel?
    var cellNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        networkObject.delegate = self
        networkObject.fetchData(demand: senderView)
    }
    
    func updateFromAPI(data: Any) {
        DispatchQueue.main.async {
        
            self.decodedData = (data as! DetailsViewModel)
            
            switch self.senderView{
            case Constants.SegueManager.SenderValues.rocket :
                self.cellNumber = self.decodedData?.rocket?.count ?? 0
                break
                
            case Constants.SegueManager.SenderValues.landpads :
                self.cellNumber = self.decodedData?.landpads?.count ?? 0
                
            default:
                break
            }
            
            
            self.tableView.reloadData()
            
        }
    }
    
    func error(error: Error) {
        print(error)
    }
    
}
  




// MARK: - Table view data source
    
extension DetailsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNumber
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsTableViewCell
        
        switch senderView {
        
        case Constants.SegueManager.SenderValues.rocket:
            cell.title.text = decodedData?.rocket![indexPath.row].rocket_name
            cell.details.text = decodedData?.rocket![indexPath.row].description
            let image_num = Int.random(in: 0..<(decodedData?.rocket![indexPath.row].flickr_images.count)!)
            cell.photo.downloadImage(from: (decodedData?.rocket![indexPath.row].flickr_images[image_num])!)
            break
        
        case Constants.SegueManager.SenderValues.landpads:
            cell.title.text = decodedData?.landpads![indexPath.row].full_name
            cell.details.text = decodedData?.landpads![indexPath.row].details
            cell.subTitle.text = "\( decodedData?.landpads![indexPath.row].location.name ?? ""), \( decodedData?.landpads![indexPath.row].location.region ?? "")"
            break
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame:CGRect (x: 0, y: 0, width: 320, height: 20) ) as UIView
        view.backgroundColor = UIColor.clear
        return view
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame:CGRect (x: 0, y: 0, width: 320, height: 20) ) as UIView
        view.backgroundColor = UIColor.clear
        return view
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
