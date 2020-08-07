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
        XCTAssertEqual("DetailView", sut.segueManager.detailViewSegue)
        XCTAssertEqual("rocket", Constants.segueManager.senderValues.rocket)
        XCTAssertEqual("launchSite", Constants.segueManager.senderValues.launchSite)
        XCTAssertEqual("landpads", Constants.segueManager.senderValues.landpads)
        XCTAssertEqual("capsules", Constants.segueManager.senderValues.capsules)
        XCTAssertEqual("ships", Constants.segueManager.senderValues.ships)
        XCTAssertEqual("launches", Constants.segueManager.senderValues.launches)
    }

}
