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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustSize()
        
    }
    
    func adjustSize(){
        if UIScreen.main.bounds.height<896 {
            aboutSpaceConstraint.constant = UIScreen.main.bounds.height*0.03
            licenseBottomConstraint.constant = UIScreen.main.bounds.height*0.03
            aboutSpaceTopConstraint.constant = UIScreen.main.bounds.height*0.005
        }
    }
}
