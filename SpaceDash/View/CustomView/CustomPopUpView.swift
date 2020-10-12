//
//  CustomPopUpView.swift
//  SpaceDash
//
//  Created by Dheeraj Kumar Sharma on 09/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class CustomPopUpView: UIView {
    
    var delegate:RocketViewController?{
        didSet{
            closeBtn.addTarget(delegate, action: #selector(RocketViewController.closeBtnTappped), for: .touchUpInside)
        }
    }
    
    ///Demo data
    let imgArr = ["test_image", "test_image" , "test_image"]
    
    ///  Collectionview for Multiple images
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        cv.setCollectionViewLayout(layout, animated: false)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.bounces = false
        return cv
    }()
    
    /// Rocket Description
    public let descriptionText:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.textColor = .black
        l.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        return l
    }()
    
    /// Page controlls
    private let pageControl:UIPageControl = {
        let c = UIPageControl()
        c.translatesAutoresizingMaskIntoConstraints = false
        c.currentPage = 0
        return c
    }()
    
    /// Close the modal
    private let closeBtn:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    /// Divider Line
    private let dividerLine:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return v
    }()
    
    /// Wikepedia btn
    private let wekipediaBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Wekipedia", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        layer.cornerRadius = 25
        layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
        addSubview(collectionView)
        addSubview(descriptionText)
        addSubview(closeBtn)
        addSubview(dividerLine)
        addSubview(wekipediaBtn)
        addSubview(pageControl)
        setUpConstraints()
        
        /// Setting up page controls
        if imgArr.count == 1 {
            pageControl.isHidden = true
        } else {
            pageControl.isHidden = false
            pageControl.numberOfPages = imgArr.count
        }
        
        collectionView.layer.cornerRadius = 25
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setting up constraints
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 270),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -30),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionText.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            closeBtn.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            closeBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            closeBtn.widthAnchor.constraint(equalToConstant: 30),
            closeBtn.heightAnchor.constraint(equalToConstant: 30),
            
            dividerLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dividerLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dividerLine.heightAnchor.constraint(equalToConstant: 0.7),
            dividerLine.bottomAnchor.constraint(equalTo: wekipediaBtn.topAnchor, constant: -10),
            
            wekipediaBtn.widthAnchor.constraint(equalToConstant: 120),
            wekipediaBtn.heightAnchor.constraint(equalToConstant: 40),
            wekipediaBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            wekipediaBtn.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / collectionView.frame.width)
    }

}

extension CustomPopUpView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.image.image = UIImage(named: imgArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
