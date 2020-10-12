//
//  RocketViewController.swift
//  SpaceDash
//
//  Created by Dheeraj Kumar Sharma on 11/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class RocketViewController: UIViewController {

    public let rocketName:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Falcon9"
        l.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        l.textColor = .black
        return l
    }()
    
    public lazy var rocketImage:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "f_9")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    public let upcomingLaunchMetric:CustomMetricCard = {
        let v = CustomMetricCard()
        v.title.text = "Upcoming Launch"
        v.subTitle.text = "Sep 27, 2020 at 8:13PM"
        return v
    }()
    
    public let latestLaunchMetric:CustomMetricCard = {
        let v = CustomMetricCard()
        v.title.text = "Latest Launch"
        v.subTitle.text = "Sep 27, 2020 at 8:13PM"
        return v
    }()
    
    public let firstLaunchMetric:CustomMetricCard = {
        let v = CustomMetricCard()
        v.title.text = "First Launch"
        v.subTitle.text = "Jan 6, 2018"
        return v
    }()
    
    public let engineAndThrustMetric:CustomMetricCard = {
        let v = CustomMetricCard()
        v.title.text = "Engine, Thrust"
        v.subTitle.text = "Merlin 1D+, 914 KN"
        return v
    }()
    
    public let descriptionMetric:CustomMetricCard = {
        let v = CustomMetricCard()
        v.title.text = "Description"
        v.subTitle.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        v.subTitle.numberOfLines = 0
        return v
    }()
    
    public lazy var readMoreBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("ReadMore", for: .normal)
        btn.setTitleColor(UIColor.init(named: Constants.Colors.DashCream), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = CGFloat(15)
        btn.addTarget(self, action: #selector(readmoreBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    let bottomBlackView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        return v
    }()
    
    let pathView:UIView = {
        let v  = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.init(named: Constants.Colors.DashCream)
        v.layer.cornerRadius = 35
        v.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return v
    }()
    
    /// Creating instance of CustomPopUpView
    lazy var popUpView:CustomPopUpView = {
        let v = CustomPopUpView()
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let overlayView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return v
    }()
    
    /// For dynamic height for popUpCard
    var popUpViewCardHeight:CGFloat?
    
    /// Inorder to animate popUpView from bottom we need to change its bottom constraints, so assigning bottom constraints separately.
    var popUpBottomConstraint:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: Constants.Colors.DashCream)
        setCustomNavBar()
        
        view.addSubview(bottomBlackView)
        bottomBlackView.addSubview(pathView)
        view.addSubview(rocketImage)
        view.addSubview(rocketName)
        view.addSubview(upcomingLaunchMetric)
        view.addSubview(latestLaunchMetric)
        view.addSubview(firstLaunchMetric)
        view.addSubview(engineAndThrustMetric)
        view.addSubview(descriptionMetric)
        view.addSubview(readMoreBtn)
        
        setUpConstraints()
        
        /// Dynamic estimated Height of popUpCard -> On the basic of content
        self.popUpViewCardHeight = 580
        
        /// Adding a popUpView as subview and setting up it's constraints
        view.addSubview(overlayView)
        view.addSubview(popUpView)
        
        setPopupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            rocketName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rocketName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            rocketName.heightAnchor.constraint(equalToConstant: 22),
            
            rocketImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            rocketImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rocketImage.bottomAnchor.constraint(equalTo: descriptionMetric.topAnchor, constant: -20),
            rocketImage.widthAnchor.constraint(equalToConstant: 30),
            
            upcomingLaunchMetric.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            upcomingLaunchMetric.heightAnchor.constraint(equalToConstant: 60),
            upcomingLaunchMetric.trailingAnchor.constraint(equalTo: rocketImage.leadingAnchor, constant: -40),
            upcomingLaunchMetric.topAnchor.constraint(equalTo: rocketName.bottomAnchor, constant: 30),
            
            latestLaunchMetric.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            latestLaunchMetric.heightAnchor.constraint(equalToConstant: 60),
            latestLaunchMetric.trailingAnchor.constraint(equalTo: rocketImage.leadingAnchor, constant: -40),
            latestLaunchMetric.topAnchor.constraint(equalTo: upcomingLaunchMetric.bottomAnchor, constant: 25),
            
            firstLaunchMetric.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstLaunchMetric.heightAnchor.constraint(equalToConstant: 60),
            firstLaunchMetric.trailingAnchor.constraint(equalTo: rocketImage.leadingAnchor, constant: -40),
            firstLaunchMetric.topAnchor.constraint(equalTo: latestLaunchMetric.bottomAnchor, constant: 25),
            
            engineAndThrustMetric.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            engineAndThrustMetric.heightAnchor.constraint(equalToConstant: 60),
            engineAndThrustMetric.trailingAnchor.constraint(equalTo: rocketImage.leadingAnchor, constant: -40),
            engineAndThrustMetric.topAnchor.constraint(equalTo: firstLaunchMetric.bottomAnchor, constant: 25),
            
            descriptionMetric.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionMetric.heightAnchor.constraint(equalToConstant: 110),
            descriptionMetric.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionMetric.topAnchor.constraint(equalTo: engineAndThrustMetric.bottomAnchor, constant: 30),
            
            readMoreBtn.topAnchor.constraint(equalTo: descriptionMetric.bottomAnchor, constant: -15),
            readMoreBtn.heightAnchor.constraint(equalToConstant: 30),
            readMoreBtn.widthAnchor.constraint(equalToConstant: 90),
            readMoreBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomBlackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBlackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBlackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBlackView.topAnchor.constraint(equalTo: descriptionMetric.bottomAnchor, constant: -20),
            
            pathView.heightAnchor.constraint(equalToConstant: 70),
            pathView.topAnchor.constraint(equalTo: bottomBlackView.topAnchor),
            pathView.leadingAnchor.constraint(equalTo: bottomBlackView.leadingAnchor),
            pathView.trailingAnchor.constraint(equalTo: bottomBlackView.trailingAnchor)
        ])
    }
    
    /// Custom navigation bar settings
    private func setCustomNavBar(){
        navigationItem.title = "Rockets"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.init(named: Constants.Colors.DashCream)
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func readmoreBtnPressed(){
        togglePopUpView("open")
    }
    
    @objc func closeBtnTappped(){
        togglePopUpView("close")
    }
    
    /// Setting up constraints for description popUpView
    func setPopupConstraints(){
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            popUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popUpView.heightAnchor.constraint(equalToConstant: popUpViewCardHeight!)
        ])
        
        /// Initially hide popUpView by setting positive bottom constraint.
        popUpBottomConstraint = popUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: popUpViewCardHeight!)
        popUpBottomConstraint?.isActive = true
        /// Hide overlay view initially
        overlayView.isHidden = true
        overlayView.alpha = 0
    }
    
    /// It toggles the card animations, either open or close
    /// - Parameter state: It takes a string whthere card is "open" or "close"
    private func togglePopUpView( _ state:String){
        if state == "open"{
            self.popUpBottomConstraint!.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
                self.overlayView.isHidden = false
                self.overlayView.alpha = 1
            })
        } else {
            self.popUpBottomConstraint!.constant = popUpViewCardHeight!
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
                self.overlayView.alpha = 0
            }, completion: { finish in
                UIView.animate(withDuration: 0.1) {
                    self.overlayView.isHidden = true
                }
            })
        }
    }

}
