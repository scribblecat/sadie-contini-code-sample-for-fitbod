//
//  Exercise.swift
//  FitBod-CodingSample-SadieContini
//
//  Created by sadie on 12/21/17.
//  Copyright © 2017 sadiecontini. All rights reserved.
//

import Foundation

struct Exercise {
    var name: String
    var workouts: [Workout]
}

struct Workout {
    var date: String
    var sets: [Set]
}

struct Set {
    var numberOfReps: Int
    var lbs: Int
}
