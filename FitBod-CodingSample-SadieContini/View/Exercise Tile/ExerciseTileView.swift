//
//  ExerciseTileView.swift
//  FitBod-CodingSample-SadieContini
//
//  Created by sadie on 12/21/17.
//  Copyright © 2017 sadiecontini. All rights reserved.
//

import UIKit

@IBDesignable
class ExerciseTileView: BaseReusableXibView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oneRepMaxLabel: UILabel!

    var exercise: Exercise! {
        didSet {
            nameLabel?.text = exercise.name
            oneRepMaxLabel?.text = String(exercise.oneRepMax())
        }
    }
    
    // MARK: - Configure UI
    func configure(withExercise ex: Exercise) {
        exercise = ex
    }
}
