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
        XCTAssertEqual("https://api.spacexdata.com/v3/", sut.NetworkManager.baseURL)
        XCTAssertEqual("launches/Upcoming", sut.NetworkManager.upcomingLaunchURL)
        XCTAssertEqual("Launch Site Not Declared", sut.DefaultArgs.launchSite)
        XCTAssertEqual("Not Available", sut.DefaultArgs.noData)
        XCTAssertEqual("DetailView", sut.SegueManager.detailViewSegue)
        XCTAssertEqual("rockets", Constants.SegueManager.SenderValues.rocket)
        XCTAssertEqual("launchpads", Constants.SegueManager.SenderValues.launchSite)
        XCTAssertEqual("landpads", Constants.SegueManager.SenderValues.landpads)
        XCTAssertEqual("capsules", Constants.SegueManager.SenderValues.capsules)
        XCTAssertEqual("ships", Constants.SegueManager.SenderValues.ships)
        XCTAssertEqual("launches", Constants.SegueManager.SenderValues.launches)
    }

}
