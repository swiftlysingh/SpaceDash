//
//  AboutViewController.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 31/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var aboutSpaceTopConstraint: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustSize()
        
    }
      
      @IBAction func privacyButtonPressed(_ sender: UIButton) {
        checkIfAppCanOpenURL(urlString: Constants.AboutView.privacyURLString)
        openUrl(with: Constants.AboutView.privacyURLString)
          
      }
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
      
    
    func adjustSize(){
        aboutSpaceConstraint.constant = UIScreen.main.bounds.height*0.03
        aboutSpaceTopConstraint.constant = UIScreen.main.bounds.height*0.01
    }
}
