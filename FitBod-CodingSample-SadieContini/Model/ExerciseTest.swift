//
//  ExerciseTest.swift
//  FitBod-CodingSample-SadieContiniTests
//
//  Created by sadie on 1/2/18.
//  Copyright © 2018 sadiecontini. All rights reserved.
//

import XCTest
@testable import FitBod_CodingSample_SadieContini

class ExerciseTest: XCTestCase {
    
    var exercises = [Exercise]()
    var backSquat = Exercise()
    var deadlift = Exercise()
    
    override func setUp() {
        super.setUp()
        populateExercises()
    }
    
    override func tearDown() {
        exercises = [Exercise]()
        backSquat = Exercise()
        deadlift = Exercise()
        super.tearDown()
    }
    
    func testOneRepMax() {
        var value = deadlift.workouts[0].oneRepMax()
        XCTAssert(value == 333, "one rep max was incorrect: \(value)")
        
        value = deadlift.oneRepMax()
        XCTAssert(value == 333, "one rep max was incorrect: \(value)")
        
        value = backSquat.workouts[2].oneRepMax()
        XCTAssert(value == 238, "one rep max was incorrect: \(value)")

        value = backSquat.oneRepMax()
        XCTAssert(value == 284, "one rep max was incorrect: \(value)")
    }
    
    // MARK: - Helper Methods
    
    func populateExercises() {
        
        // Add Back Squat
        backSquat = TestExerciseFactory.createBackSquat()
        exercises.append(backSquat)

        // Add Deadlift
        deadlift = TestExerciseFactory.createDeadlift()
        exercises.append(deadlift)
    }
    
}
