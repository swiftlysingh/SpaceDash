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
    
    /// Tests the Button title of every button present in scroll view that will help in calling appropriate API Endpoint
    func testButtonTitleSegue() throws {
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        
        XCTAssert(elementsQuery.buttons["rockets"].exists)
        XCTAssert(elementsQuery.buttons["launches"].exists)
        XCTAssert(elementsQuery.buttons["landpads"].exists)
        XCTAssert(elementsQuery.buttons["ships"].exists)
        XCTAssert(elementsQuery.buttons["capsules"].exists)
        XCTAssert(elementsQuery.buttons["launchpads"].exists)
    }
    
    func testTentativePopup() throws {
        
        let app = XCUIApplication()
        if app.buttons["T"].exists {
            app.buttons["T"].tap()
            XCTAssert(app.popovers.staticTexts["This is the tentative launch date and subjected to change"].exists)
        }
    }
    
    func testAboutUI() throws {
        
        let app = XCUIApplication()
        app.tabBars.buttons["About"].twoFingerTap()
        
        let aboutSpaceXTitle = app.staticTexts["About SpaceX"]
        let aboutSpaceXPred = NSPredicate(format: "label like 'Space Exploration Technologies Corp., trading as SpaceX, is an American aerospace manufacturer and space transportation services company headquartered in Hawthorne, California. It was founded in 2002 by Elon Musk with the goal of reducing space transportation costs to enable the colonization of Mars.'")
        let aboutSpaceXDesc = app.staticTexts.element(matching: aboutSpaceXPred)
        
        let aboutSpaceDashTitle = app.staticTexts["About SpaceDash"]
        let aboutSpaceDashPred = NSPredicate(format: "label like'SpaceDash will be Dashboard for all things Space. It is a beautiful app with simple but informative UI. You will be able to simply glance at the upcoming launches for various space agency. And even watch it live if there is a live stream happening (Coming in the future version of the app). Currently the app supports launches, missions, rockets etc for SpaceX but more space agencies will be added soon.'")
        let aboutSpaceDashDesc = app.staticTexts.element(matching: aboutSpaceDashPred)
        
        if app.tabBars.buttons["About"].isSelected {
            XCTAssertTrue(aboutSpaceXDesc.exists)
            XCTAssertTrue(aboutSpaceXTitle.exists)
            XCTAssertTrue(aboutSpaceDashDesc.exists)
            XCTAssertTrue(aboutSpaceDashTitle.exists)
        }
        
    
        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["Change App Icon"]/*[[".buttons[\"Change App Icon\"].staticTexts[\"Change App Icon\"]",".staticTexts[\"Change App Icon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["Privacy Policy"]/*[[".buttons[\"Privacy Policy\"].staticTexts[\"Privacy Policy\"]",".staticTexts[\"Privacy Policy\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        
        
    }
}

