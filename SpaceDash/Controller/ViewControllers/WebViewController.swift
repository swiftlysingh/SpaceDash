//
//  WebViewController.swift
//  SpaceDash
//
//  Created by Dheeraj Kumar Sharma on 13/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var url:URL?
        
    let webView:WKWebView = {
        let v = WKWebView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.init(named: Constants.Colors.DashCream)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: Constants.Colors.DashCream)
        view.addSubview(webView)
        setUpConstraints()
        setUpCustomNavigations()
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func setUpCustomNavigations(){
        
        navigationItem.title = "WebView"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.barTintColor = UIColor.init(named: Constants.Colors.DashCream)
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16 , weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.init(named: Constants.Colors.DashBlack)!
        ]
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setBackgroundImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cancelButton.tintColor = UIColor.init(named: Constants.Colors.DashBlack)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelBtn), for: .touchUpInside)
        let leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.customView = cancelButton
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func cancelBtn(){
        dismiss(animated: true, completion: nil)
    }

}
