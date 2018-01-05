//
//  Exercise.swift
//  FitBod-CodingSample-SadieContini
//
//  Created by sadie on 12/21/17.
//  Copyright © 2017 sadiecontini. All rights reserved.
//

import Foundation

class Exercise {
    var name = ""
    var workouts = [Workout]()
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }

    func mostRecentOneRepMax() -> Int {
        // TODO: don't assume that the data is ordered from
        // earliest to most recent
        if let workout = workouts.last {
            return workout.oneRepMax()
        }
        return 0
    }
    
    func oneRepMax() -> Int {
        var maxWeight = 0
        for workout in workouts {
            maxWeight = max(maxWeight, workout.oneRepMax())
        }
        return maxWeight
    }
}

// For the purpose of this code sample,
// all sets performed on the same date are considered to be
// part of the same workout for a given exercise.
class Workout {
    var date = Date() // date is string for purposes of this code sample
    var sets = [Set]()
    
    convenience init(date: Date) {
        self.init()
        self.date = date
    }
    
    // calculate the 1 rep max for each set, then
    // take the highest 1 rep max of the day for the plot
    func oneRepMax() -> Int {
        var maxWeight = 0
        for set in sets {
            maxWeight = max(maxWeight, set.oneRepMax())
        }
        return maxWeight
    }
}

struct Set {
    var numberOfReps: Int
    var lbs: Int
    
    // Returns the one-rep max based on this set,
    // using the Brzycki Formula found here:
    // https://en.wikipedia.org/wiki/One-repetition_maximum
    func oneRepMax() -> Int {
        return Int(Double(lbs)/(1.0278 - 0.0278*Double(numberOfReps)))
    }
}
