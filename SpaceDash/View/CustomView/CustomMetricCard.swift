//
//  CustomMetricCard.swift
//  SpaceDash
//
//  Created by Dheeraj Kumar Sharma on 09/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class CustomMetricCard: UIView {
    
    let title:UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let subTitle:UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame:frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.init(named: Constants.Colors.DashCream)
        layer.cornerRadius = CGFloat(10)
        addSubview(title)
        addSubview(subTitle)
        setUpConstraints()
        
        /// Adding shadow to view
        layer.shadowColor = UIColor(white: 0, alpha: 0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            subTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            subTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            subTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
