//
//  SpaceDashConstantsCheck.swift
//  SpaceDashConstantsCheck
//
//  Created by Pushpinder Pal Singh on 26/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import XCTest

@testable import SpaceDash

class SpaceDashConstantsCheck: XCTestCase {
    
    var sut = SpaceDash.Constants.self
    
    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testConstant() throws {
        XCTAssertEqual("https://api.spacexdata.com/v3/", sut.Networking.baseURL)
        XCTAssertEqual("launches/Upcoming", sut.Networking.upcomingLaunchURL)
        XCTAssertEqual("Launch Site Not Declared", sut.defaultArgs.launchSite)
        XCTAssertEqual("Not Available", sut.defaultArgs.noData)
        XCTAssertEqual("DetailView", sut.segue.detailViewSegue)
    }

}
