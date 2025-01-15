//
//  CVSAssessmentUITests.swift
//  CVSAssessmentUITests
//
//  Created by krunal mistry on 1/14/25.
//

import XCTest

final class CVSAssessmentUITests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testSearchBarStaysAtTopDuringLoading() throws {

        let searchBar = app.textFields["Search Images"]

        let exists = searchBar.waitForExistence(timeout: 20) // Increase timeout as needed
        XCTAssertTrue(exists, "Search bar should exist")

        let searchBarFrameBeforeLoading = searchBar.frame
        
        searchBar.tap()
        searchBar.typeText("kittens")

        let searchBarFrameDuringLoading = searchBar.frame
        XCTAssertEqual(
            searchBarFrameBeforeLoading.origin.y,
            searchBarFrameDuringLoading.origin.y,
            "Search bar should stay at the top during loading"
        )
    }
    
    func testImageGridAppearsAfterLoading() throws {
        let searchBar = app.textFields["Search Images"]
        let searchExists = searchBar.waitForExistence(timeout: 20) // Increase timeout as needed
        XCTAssertTrue(searchExists, "Search bar should exist")
        searchBar.tap()
        searchBar.typeText("kittens")
        let gridCell = app.images.element(boundBy: 0)
        let exists = gridCell.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Grid should show images after loading")
    }
}
