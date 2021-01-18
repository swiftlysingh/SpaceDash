//
//  ReusableView.swift
//  SpaceDash
//
//  Created by akhigbe benjamin on 15/12/2020.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//


import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView{}
extension UITableViewCell: ReusableView{}

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView{
    static var nibName: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
