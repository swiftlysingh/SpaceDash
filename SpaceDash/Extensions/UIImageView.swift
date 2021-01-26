//
//  UIImage.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 08/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
    
    convenience init(cornerRadius: CGFloat){
        self.init(frame: .zero)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
    
    convenience init(imageName: String){
        self.init(frame: .zero)
        self.image = UIImage(named: imageName)
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
