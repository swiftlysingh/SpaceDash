//
//  TentativeDetailsViewController.swift
//  SpaceDash
//
//  Created by Waseem Akram on 02/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class TentativeDetailsViewController: UIViewController {

     var lblTentativeDetail = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(named: Constants.Colors.DashCream)
        view.addSubview(lblTentativeDetail)
        lblTentativeDetail.numberOfLines = 0
        lblTentativeDetail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblTentativeDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblTentativeDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lblTentativeDetail.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            lblTentativeDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }    
    
}
