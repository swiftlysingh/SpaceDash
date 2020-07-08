//
//  SpaceXUITests.swift
//  SpaceXUITests
//
//  Created by Pushpinder Pal Singh on 08/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import XCTest

class SpaceXUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }
    
    override func tearDownWithError() throws {
        app = nil
        super.tearDown()
    }
    
    func testHomeUI() throws {
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        let upcomingLaunch = app.staticTexts["Upcoming Launch"]
        let launchDate = app.staticTexts["Launch Date"]
        let launchSite = app.staticTexts["Launch Site"]
        let payloadType = app.staticTexts["Payload & Type"]
        
        
        let landPads = elementsQuery.staticTexts["Land Pads"]
        let capsules = elementsQuery.staticTexts["Capsules"]
        let rockets = elementsQuery.staticTexts["Rockets"]
        let allLaunches = elementsQuery.staticTexts["All Launches"]
        let launchSites = elementsQuery.staticTexts["Launch Sites"]
        let ships = elementsQuery.staticTexts["Ships"]
        
        let homeView = XCUIApplication().tabBars.buttons["Home"]
        if homeView.isSelected {
            XCTAssertTrue(upcomingLaunch.exists)
            XCTAssertTrue(launchDate.exists)
            XCTAssertTrue(launchSite.exists)
            XCTAssertTrue(launchDate.exists)
            XCTAssertTrue(payloadType.exists)
            XCTAssertTrue(landPads.exists)
            XCTAssertTrue(capsules.exists)
            XCTAssertTrue(rockets.exists)
            XCTAssertTrue(allLaunches.exists)
            XCTAssertTrue(launchSites.exists)
            XCTAssertTrue(ships.exists)
        }
    }
}
