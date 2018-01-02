//
//  ExerciseTableVC.swift
//  FitBod-CodingSample-SadieContini
//
//  Created by sadie on 12/21/17.
//  Copyright © 2017 sadiecontini. All rights reserved.
//

import UIKit

class ExerciseTableVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataManager.delegate = self
        dataManager.loadData() // loads in background thread
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO: show user activity indicator, progress bar,
        // etc. if data hasn't been loaded yet
        tableView?.reloadData()
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let exercise = dataManager.exercises[indexPath.row]
        
        let vc = ExerciseDetailVC.createFromStoryboard(exercise: exercise)
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.title = " "
    }
}

// MARK: - UITableViewDataSource

extension ExerciseTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ExerciseTableCell.self),
                                                 for: indexPath) as! ExerciseTableCell
        let exercise = dataManager.exercises[indexPath.row]
        cell.configure(withExercise: exercise, oneRepMax: 100)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataManager.exercises.count
    }
}

// MARK: - DataManagerDelegate
extension ExerciseTableVC: DataManagerDelegate {
    // handling race condition --
    // if we get data first, table data loads in viewWillAppear.
    // if we get view first, table data loads here after mgr loads it.
    func didLoadData() {
        tableView?.reloadData()
    }
}

