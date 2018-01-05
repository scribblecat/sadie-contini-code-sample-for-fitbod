//
//  ExerciseDetailVC.swift
//  FitBod-CodingSample-SadieContini
//
//  Created by sadie on 12/31/17.
//  Copyright © 2017 sadiecontini. All rights reserved.
//

import UIKit

class ExerciseDetailVC: UIViewController {
    
    @IBOutlet weak var exerciseTileView: ExerciseTileView!

    var exercise: Exercise!
    
    class func createFromStoryboard(exercise: Exercise) -> ExerciseDetailVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier : String(describing: ExerciseDetailVC.self)) as! ExerciseDetailVC
        viewController.exercise = exercise
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        exerciseTileView.configure(withExercise: exercise)
    }
}
