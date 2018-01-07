//
//  ChartViewTests.swift
//  FitBod-CodingSample-SadieContiniTests
//
//  Created by sadie on 1/5/18.
//  Copyright © 2018 sadiecontini. All rights reserved.
//

import XCTest
@testable import FitBod_CodingSample_SadieContini

class ChartViewTests: XCTestCase {
    
    var backSquat = TestExerciseFactory.createBackSquat()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateEntryArray() {
        let chartView = ChartView()
        let entries = chartView.createEntryArray(for: backSquat)
        XCTAssert(entries.count == 3, "Back Squat should have 3 entries but has \(entries.count) instead")
    }
    
    // TODO: fix test when you update xAxis creation...
    func testCreateXAxisArray() {
        let chartView = ChartView()
        let xAxisValues = chartView.createXAxisArray(for: backSquat)
        
        var date = DataManager.dateFromDataFileString("Oct 15 2016")
        XCTAssert(xAxisValues[0] == date, "X Axis value should be \(date!): \(xAxisValues[0])")
        
        date = DataManager.dateFromDataFileString("Sep 28 2017")
        XCTAssert(xAxisValues[1] == date, "X Axis value should be \(date!): \(xAxisValues[1])")
        
        date = DataManager.dateFromDataFileString("Oct 11 2017")
        XCTAssert(xAxisValues[2] == date, "X Axis value should be \(date!): \(xAxisValues[2])")

    }
}
