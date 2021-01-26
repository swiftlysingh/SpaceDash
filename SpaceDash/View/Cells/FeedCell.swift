//
//  NewsCell.swift
//  SpaceDash
//
//  Created by akhigbe benjamin on 15/12/2020.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    
    //MARK:- PRIVATE CONSTANTS
    private let newImage : UIImageView = {
        let imageView = UIImageView(imageName: Constants.Images.stockImage)
        imageView.constrainHeight(constant: 170)
        return imageView
    }()
    
    public let titleLabel = UILabel(text: Constants.NewCell.title, font: .playFairDisplay(), numberOfLine: 2, textColor: .white)
    
    public let descriptionLabel = UILabel(text: Constants.NewCell.description, font: .lora(), numberOfLine: 5, textColor: .white)
    
    //MARK:- PRIVATE VARIABLES
    
    private var overallStackView = UIStackView()
    
    private var mainView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- PRIVATE FUNCTIONS
    
    private func setupView (){

        overallStackView = VerticalStackView(arrangedSubviews: [newImage, titleLabel, descriptionLabel], spacing: 16)
        titleLabel.numberOfLines = 2
        descriptionLabel.numberOfLines = 5
        addSubview(mainView)
        mainView.addSubview(overallStackView)
        setupViewConstraints()

    }
    
    private func setupViewConstraints(){
       
        overallStackView.fillSuperview()
        mainView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        mainView.constrainWidth(constant: UIScreen.main.bounds.width - 40)
    }

}
