//
//  FastlaneSnapshots.swift
//  FastlaneSnapshots
//
//  Created by Pushpinder Pal Singh on 08/09/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import XCTest

class FastlaneSnapshots: XCTestCase {
    
    var app : XCUIApplication!
    
    override func setUpWithError() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        super.tearDown()
    }
    
func testSnapshots() throws {
    
    let app = XCUIApplication()
    snapshot("01) Home")
    app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .button).element.tap()
    snapshot("03) Detail View",waitForLoadingIndicator: true )
    app.tabBars.buttons["About"].tap()
    snapshot("02) About")
    }
}
