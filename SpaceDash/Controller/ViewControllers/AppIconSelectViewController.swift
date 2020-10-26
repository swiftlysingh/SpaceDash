//
//  AppIconSelectViewController.swift
//  SpaceDash
//
//  Created by Raj Raval on 26/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class AppIconSelectViewController: UIViewController {
    
    @IBOutlet weak var iconSegmentedControl: UISegmentedControl!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissTapped))
    
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 13
        
        let selectedIndex = UserDefaults.standard.integer(forKey: "appIcon")
        iconSegmentedControl.selectedSegmentIndex = selectedIndex
        
        iconImageView.image = setImageView(selectedIndex: selectedIndex)
    }
    
    @IBAction func iconIndexChanged(_ sender: UISegmentedControl) {
        let selectedIconIndex = sender.selectedSegmentIndex
        UserDefaults.standard.setValue(selectedIconIndex, forKey: "appIcon")
        let iconName = setIconName(selectedIndex: selectedIconIndex)
        changeAppIcon(to: iconName)
        iconImageView.image = setImageView(selectedIndex: selectedIconIndex)
    }
    
    func changeAppIcon(to name: String?) {
        UIApplication.shared.setAlternateIconName(name) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("App Icon Changed!")
            }
        }
    }
    
    @objc func dismissTapped() {
        dismiss(animated: true)
    }
    
    func setIconName(selectedIndex: Int) -> String? {
        switch selectedIndex {
        case 1:
            return "SpaceShuttle"
        case 2:
            return "Rocket"
        default:
            return nil
        }
    }
    
    func setImageView(selectedIndex: Int) -> UIImage! {
        switch selectedIndex {
        case 1:
            return UIImage(named: "SpaceDashIconSpaceShuttle")
        case 2:
            return UIImage(named: "SpaceDashIconRocket")
        default:
            return UIImage(named: "SpaceDashIconShuttle")
        }
    }
    
}
