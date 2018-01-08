//
//  DataManager.swift
//  FitBod-CodingSample-SadieContini
//
//  Created by sadie on 12/21/17.
//  Copyright © 2017 sadiecontini. All rights reserved.
//

import Foundation

protocol DataManagerDelegate {
    func didLoadData()
}

class DataManager {
    
    // Singleton
    static let shared = DataManager()
    private init() {} 

    var delegate: DataManagerDelegate?

    let dataFileName = "workoutData"
    let dataFileExt = "txt"
    
    // TODO: consider moving exercises to dict instead of array
    var exercises = [Exercise]()
    
    // MARK: - Data Loading
    
    public func loadData(fileName: String? = nil) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.load(fileName: fileName)
        }
    }
    
    private func load(fileName: String? = nil) {
        var data = csvData(fromFileName: fileName ?? dataFileName, fromFileExt: dataFileExt)
        data = cleanRows(file: data!)
        let csvRows = array(fromData: data!)
    
        for fields in csvRows {
            
            guard fields.count == 5 else {
                continue
            }
            
            // example data file line:
            // Jun 06 2017,Barbell Bench Press,1,10,45
            let exerciseName = fields[1]
            
            if let date = DataManager.dateFromDataFileString(fields[0]),
                let reps = Int(fields[3]),
                let lbs = Int(fields[4]) {
                
                // Find or append this exercise
                var thisExercise = Exercise(name: exerciseName)
                let exercisesFiltered = exercises.filter{ $0.name == thisExercise.name }
                if let existingExercise = exercisesFiltered.first {
                    thisExercise = existingExercise
                } else {
                    exercises.append(thisExercise)
                }
                
                // Find or append this workout
                var thisWorkout = Workout(date: date)
                let filteredWorkouts = thisExercise.workouts.filter{ $0.date == date}
                if let existingWorkout = filteredWorkouts.first {
                    thisWorkout = existingWorkout
                } else {
                    thisExercise.workouts.append(thisWorkout)
                }

                // Append this set
                let thisSet = Set(numberOfReps: reps, lbs: lbs)
                thisWorkout.sets.append(thisSet)
            }
        }
        DispatchQueue.main.async {
            self.delegate?.didLoadData()
        }
    }
    
    private func array(fromData data: String) -> [[String]] {
        var result = [[String]]()
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            if row.contains(",") {
                let columns = row.components(separatedBy: ",")
                result.append(columns)
            }
        }
        return result
    }
    
    private func csvData(fromFileName fileName:String, fromFileExt fileExt: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName,
                                              ofType: fileExt) else {
            // TODO: use consolidated error handling. provide popup message to user, offer user to send logs, and/or log error with analytics.
            print("Error: Cannot locate file \(fileName).\(fileExt)")
            return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath,
                                      encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            // TODO: use consolidated error handling. provide popup message to user, offer user to send logs, and/or log error with analytics.
            print("Error: Cannot read file \(filepath)")
            return nil
        }
    }
    
    private func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    
    class func dateFromDataFileString(_ dateText: String) -> Date? {
        // example: Oct 29 2016
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM dd yyyy"
        return dateformatter.date(from: dateText)
    }
}
