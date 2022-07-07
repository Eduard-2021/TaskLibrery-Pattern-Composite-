//
//  TaskTableViewCell.swift
//  TaskLibrery(Pattern Composite)
//
//  Created by Eduard on 21.08.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var numberSubTaskLabel: UILabel!
    
    func config(task: String, numberSubTask: Int){
        taskLabel.text = task
        numberSubTaskLabel.text = "Количество подзадач: \(numberSubTask)"
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            taskLabel.text = nil
            numberSubTaskLabel.text = nil
    }
}
