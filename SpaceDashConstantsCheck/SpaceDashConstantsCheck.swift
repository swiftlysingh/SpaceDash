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
        XCTAssertEqual("DetailsTableViewCell", Constants.DetailsView.nibName)
        XCTAssertEqual("cell", Constants.DetailsView.reuseId)
        XCTAssertEqual("DashBlack", Constants.Colors.DashBlack)
        XCTAssertEqual("DashCream", Constants.Colors.DashCream)
        XCTAssertEqual("https://github.com/pushpinderpalsingh/SpaceDash/blob/master/LICENSE", Constants.AboutView.licenseURLString)
        XCTAssertEqual("https://pushpinderpalsingh.github.io/SpaceDash/policy.html", Constants.AboutView.privacyURLString)
        XCTAssertEqual("Unable to open due to some reasons please check back later", Constants.AboutView.alertMessage)
        XCTAssertEqual("Ok", Constants.AboutView.okButtonTitle)
        XCTAssertEqual("This is the tentative launch date and subjected to change", Constants.HomeView.tentativeDetail)
        XCTAssertEqual("SpaceDashIconSpaceShuttle", Constants.AppIcon.spaceShuttle)
        XCTAssertEqual("SpaceDashIconShuttle", Constants.AppIcon.shuttle)
        XCTAssertEqual("SpaceDashIconRocket", Constants.AppIcon.rocket)
    }

}
