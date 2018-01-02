//
//  DataManagerTest.swift
//  FitBod-CodingSample-SadieContiniTests
//
//  Created by sadie on 12/31/17.
//  Copyright © 2017 sadiecontini. All rights reserved.
//

import XCTest

class DataManagerTest: XCTestCase, DataManagerDelegate {
    
    var manager = DataManager()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        manager.delegate = self
        manager.loadData(fileName: "workoutDataTest")
    }
    
    func completeTest() {
        let exercises = manager.exercises
        XCTAssert(exercises.count == 3, "exercises count should be 3 but is: \(exercises.count)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func didLoadData() {
        completeTest()
    }
    
}
