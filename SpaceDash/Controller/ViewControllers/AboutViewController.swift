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
    @IBOutlet weak var licenseBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var aboutSpaceTopConstraint: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustSize()
        
    }
    
    @IBAction func licenseButtonPressed(_ sender: UIButton) {
          let licenseURLString = "https://github.com/pushpinderpalsingh/SpaceDash/blob/master/LICENSE"
          checkIfAppCanOpenURL(urlString: licenseURLString)
          openUrl(with: licenseURLString)
      }
      
      @IBAction func privacyButtonPressed(_ sender: UIButton) {
          let privacyURLString = "https://pushpinderpalsingh.github.io/SpaceDash/policy.html"
          checkIfAppCanOpenURL(urlString: privacyURLString)
          openUrl(with: privacyURLString)
          
      }
      func checkIfAppCanOpenURL(urlString: String){
          if let url = URL(string: urlString), !url.absoluteString.isEmpty{
              UIApplication.shared.canOpenURL(url)
          }else{
              let OKButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
              let alertController = UIAlertController(title: "Unable to open due to some reasons please check back later", message: nil, preferredStyle: .alert)
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
        licenseBottomConstraint.constant = UIScreen.main.bounds.height*0.03
        aboutSpaceTopConstraint.constant = UIScreen.main.bounds.height*0.01
    }
}
