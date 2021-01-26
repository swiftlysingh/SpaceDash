//
//  NewsListViewController.swift
//  SpaceDash
//
//  Created by akhigbe benjamin on 06/12/2020.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
import SnapKit


class FeedViewController: UIViewController{
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var newsContainerView: UIView!
    
    @IBOutlet weak var articleContainerView: UIView!
    
    
    let segmentindicator: UIView = {
        
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeSegmentedControl()
    }
    
    fileprivate func customizeSegmentedControl(){
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
        segmentedControl.clearBG()
        segmentedControl.fontStateStyle(font: UIFont.playFairDisplay(.bold, size: 20), fontColor: UIColor(named: Constants.Colors.DashGray)!, state: .normal)
        segmentedControl.fontStateStyle(font: UIFont.playFairDisplay(.bold, size: 20), fontColor: .white, state: .selected)
        self.view.addSubview(segmentindicator)
        setupConstraint()
    }
    
    func setupConstraint() {
        articleContainerView.isHidden = true
        segmentindicator.snp.makeConstraints { (make) in
            
            make.top.equalTo(segmentedControl.snp.bottom).offset(1)
            make.height.equalTo(3)
            
            make.width.equalTo(40 + segmentedControl.titleForSegment(at: 0)!.count * 4)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(segmentedControl.numberOfSegments)
        }
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        let numberOfSegments = CGFloat(segmentedControl.numberOfSegments)
        let selectedIndex = CGFloat(sender.selectedSegmentIndex)
        let titlecount = CGFloat((segmentedControl.titleForSegment(at: sender.selectedSegmentIndex)!.count))
        
        segmentindicator.snp.remakeConstraints { (make) in
            
            make.top.equalTo(segmentedControl.snp.bottom).offset(1)
            make.height.equalTo(3)
            make.width.equalTo(60 + titlecount * 8)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(numberOfSegments / CGFloat(3.0 + CGFloat(selectedIndex-1.0)*2.0))
            
        }
        switchView(selectedIndex: Int(selectedIndex))
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
            self.segmentindicator.transform = CGAffineTransform(scaleX: 1.4, y: 1)
        }) { (finish) in
            UIView.animate(withDuration: 0.3, animations: {
                self.segmentindicator.transform = CGAffineTransform.identity
            })
        }
        
        switchView(selectedIndex: Int(selectedIndex))
    }
    
    func switchView(selectedIndex: Int){
        if selectedIndex == 0 {
            newsContainerView.animate(isHidden: false, duration: 0.4)
            articleContainerView.animate(isHidden: true, duration: 0.4)
        }else{
            newsContainerView.animate(isHidden: true, duration: 0.4)
            articleContainerView.animate(isHidden: false, duration: 0.4)
        }
        
    }     
}


