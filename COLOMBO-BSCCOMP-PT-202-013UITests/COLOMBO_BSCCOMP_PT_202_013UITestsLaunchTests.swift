//
//  COLOMBO_BSCCOMP_PT_202_013UITestsLaunchTests.swift
//  COLOMBO-BSCCOMP-PT-202-013UITests
//
//  Created by Mohamed Fazil on 2022-04-09.
//

import XCTest

class COLOMBO_BSCCOMP_PT_202_013UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
