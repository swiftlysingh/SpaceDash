//
//  ArticlesViewController.swift
//  SpaceDash
//
//  Created by akhigbe benjamin on 15/12/2020.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
    }
    
}
