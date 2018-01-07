//
//  TestExerciseFactory.swift
//  FitBod-CodingSample-SadieContiniTests
//
//  Created by sadie on 1/5/18.
//  Copyright © 2018 sadiecontini. All rights reserved.
//

import Foundation

class TestExerciseFactory {
    
    class func createBackSquat() -> Exercise {
        let backSquat = Exercise(name: "Back Squat")
        let workout = Workout(date: DataManager.dateFromDataFileString("Oct 11 2017")!)
        workout.sets.append(Set(numberOfReps: 10, lbs: 45))
        workout.sets.append(Set(numberOfReps: 10, lbs: 135))
        workout.sets.append(Set(numberOfReps: 3, lbs: 185))
        workout.sets.append(Set(numberOfReps: 6, lbs: 245))
        workout.sets.append(Set(numberOfReps: 6, lbs: 245))
        workout.sets.append(Set(numberOfReps: 6, lbs: 245))
        workout.sets.append(Set(numberOfReps: 6, lbs: 245))
        backSquat.workouts.append(workout)
        
        let workout2 = Workout(date: DataManager.dateFromDataFileString("Sep 28 2017")!)
        workout2.sets.append(Set(numberOfReps: 4, lbs: 260))
        workout2.sets.append(Set(numberOfReps: 4, lbs: 260))
        workout2.sets.append(Set(numberOfReps: 4, lbs: 260))
        backSquat.workouts.append(workout2)
        
        let workout3 = Workout(date: DataManager.dateFromDataFileString("Oct 15 2016")!)
        workout3.sets.append(Set(numberOfReps: 3, lbs: 225))
        workout3.sets.append(Set(numberOfReps: 3, lbs: 225))
        workout3.sets.append(Set(numberOfReps: 3, lbs: 225))
        workout3.sets.append(Set(numberOfReps: 3, lbs: 225))
        backSquat.workouts.append(workout3)
        
        return backSquat
    }
    
    class func createDeadlift() -> Exercise {
        let deadlift = Exercise(name: "Deadlift")
        let dlWorkout = Workout(date: DataManager.dateFromDataFileString("Sep 26 2017")!)
        dlWorkout.sets.append(Set(numberOfReps: 3, lbs: 275))
        dlWorkout.sets.append(Set(numberOfReps: 3, lbs: 295))
        dlWorkout.sets.append(Set(numberOfReps: 3, lbs: 315))
        dlWorkout.sets.append(Set(numberOfReps: 3, lbs: 315))
        dlWorkout.sets.append(Set(numberOfReps: 3, lbs: 315))
        deadlift.workouts.append(dlWorkout)
        return deadlift
    }
}
