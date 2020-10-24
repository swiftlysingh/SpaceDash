//
//  AppIconSelectTableViewController.swift
//  SpaceDash
//
//  Created by Raj Raval on 24/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class AppIconSelectTableViewController: UITableViewController {
    
    var appIconItems: [AppIcon] = AppIcon.items
    var selectedIndex: Int = UserDefaults.standard.integer(forKey: "iconIndex")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AppIconCell", bundle: nil), forCellReuseIdentifier: "AppIcon")
    }

    // MARK: Table View Data Source & Delegates

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appIconItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = appIconItems[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppIcon", for: indexPath) as? AppIconCell else {
            fatalError("Cannot dequeue AppIconCell")
        }
        cell.iconImageView.image = UIImage(named: item.imageName)
        cell.iconLabel.text = item.name
        cell.selectionStyle = .none
        
        if selectedIndex == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = appIconItems[indexPath.row]
        selectedIndex = indexPath.row
        UserDefaults.standard.setValue(selectedIndex, forKey: "iconIndex")
        tableView.reloadData()

        if item.imageName == "SpaceDashIconSpaceShuttle" {
            changeIcon(name: "SpaceShuttle")
        } else if item.imageName == "SpaceDashIconRocket" {
            changeIcon(name: "Rocket")
        } else {
            changeIcon(name: nil)
        }
    }
    
    func changeIcon(name: String?) {
        UIApplication.shared.setAlternateIconName(name) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success!")
            }
        }
    }
    
}
