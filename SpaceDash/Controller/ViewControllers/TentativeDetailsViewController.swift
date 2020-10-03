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
        view.addSubview(lblTentativeDetail)
        lblTentativeDetail.numberOfLines = 0
        //inform the layout that this view uses autolayout constraint instead of resizing masks
        lblTentativeDetail.translatesAutoresizingMaskIntoConstraints = false
        // add constraints, leading: 16, trailing: -16, top: 20, bottom: 0
        NSLayoutConstraint.activate([
            lblTentativeDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblTentativeDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lblTentativeDetail.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            lblTentativeDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }    
    
}
