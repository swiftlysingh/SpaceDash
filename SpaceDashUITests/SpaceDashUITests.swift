//
//  SpaceDashUITests.swift
//  SpaceDashUITests
//
//  Created by Pushpinder Pal Singh on 17/07/20.
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
    func testAboutUI() throws {
        
        let app = XCUIApplication()
        app.tabBars.buttons["About"].twoFingerTap()
        
        let aboutSpaceXTitle = app.staticTexts["About SpaceX"]
        let aboutSpaceXPred = NSPredicate(format: "label like 'Space Exploration Technologies Corp., trading as SpaceX, is an American aerospace manufacturer and space transportation services company headquartered in Hawthorne, California. It was founded in 2002 by Elon Musk with the goal of reducing space transportation costs to enable the colonization of Mars.'")
        let aboutSpaceXDesc = app.staticTexts.element(matching: aboutSpaceXPred)
        
        let aboutSpaceDashTitle = app.staticTexts["About SpaceDash"]
        let aboutSpaceDashPred = NSPredicate(format: "label like'SpaceDash is dashboard for all SpaceX stuff. This app will be a Dashboard for all the updates you desire from SpaceX.  This app is still under active development. I have plans of adding some AR stuff and integrating some other API’s that will help me to diversify for different Space Agencies. I hope you are as excited as me to see what’s next for this app!'")
        let aboutSpaceDashDesc = app.staticTexts.element(matching: aboutSpaceDashPred)
        
        if app.tabBars.buttons["About"].isSelected {
            XCTAssertTrue(aboutSpaceXDesc.exists)
            XCTAssertTrue(aboutSpaceXTitle.exists)
            XCTAssertTrue(aboutSpaceDashDesc.exists)
            XCTAssertTrue(aboutSpaceDashTitle.exists)
        }
        
    }
}

