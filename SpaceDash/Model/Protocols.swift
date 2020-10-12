//
//  Protocols.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 12/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func updateFromAPI( data: Any)
    func error( error: Error)
}
