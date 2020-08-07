//
//  DetailsTableViewController.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 05/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    var senderView : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsTableViewCell
        
        cell.title.text = senderView
//        cell.subTitle.text = "SUb"
//        cell.details.text = "Detals"

        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
