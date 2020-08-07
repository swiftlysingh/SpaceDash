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
    var cellNumber : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        networkObject.delegate = self
        networkObject.fetchData(demand: Constants.NetworkManager.rocketsURL)
    }
    
    func updateFromAPI(data: Any) {
        DispatchQueue.main.async {
            
            self.decodedData = (data as! DetailsViewModel)
            self.cellNumber = self.decodedData?.rocket?.count
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
        return decodedData?.rocket?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsTableViewCell
        
        cell.title.text = decodedData?.rocket![indexPath.row].rocket_name
        cell.details.text = decodedData?.rocket![indexPath.row].description

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
