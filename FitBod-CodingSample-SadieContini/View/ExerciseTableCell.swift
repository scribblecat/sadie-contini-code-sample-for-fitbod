//
//  ExerciseTableCell.swift
//  FitBod-CodingSample-SadieContini
//
//  Created by sadie on 12/31/17.
//  Copyright © 2017 sadiecontini. All rights reserved.
//

import UIKit

class ExerciseTableCell: UITableViewCell {

    @IBOutlet weak var tileView: ExerciseTileView!
    
    // MARK: - Configure UI
    func configure(withExercise ex: Exercise) {
        tileView.configure(withExercise: ex)
    }
}
