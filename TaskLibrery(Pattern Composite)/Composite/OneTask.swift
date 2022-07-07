//
//  OneTask.swift
//  TaskLibrery(Pattern Composite)
//
//  Created by Eduard on 21.08.2021.
//

import Foundation

class OneTask: TaskProtocol{
    var task: String
    
    init(task: String){
        self.task = task
    }
    
    func open() {
    }
}
