//
//  AboutViewController.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 31/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class AboutViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: Table View Data Source and Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            checkIfAppCanOpenURL(urlString: Constants.AboutView.privacyURLString)
            openUrl(with: Constants.AboutView.privacyURLString)
        } else if indexPath.row == 4 {
            checkIfAppCanOpenURL(urlString: Constants.AboutView.licenseURLString)
            openUrl(with: Constants.AboutView.licenseURLString)
        }
    }
    
    // MARK: Link Opening

    func checkIfAppCanOpenURL(urlString: String){
        if let url = URL(string: urlString), !url.absoluteString.isEmpty{
            UIApplication.shared.canOpenURL(url)
        }else{
            let OKButton = UIAlertAction(title: Constants.AboutView.okButtonTitle, style: .cancel, handler: nil)
            let alertController = UIAlertController(title: Constants.AboutView.alertMessage, message: nil, preferredStyle: .alert)
            alertController.addAction(OKButton)
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
    
    func openUrl(with urlString: String){
        if let url = URL(string: urlString), !url.absoluteString.isEmpty{
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
}
