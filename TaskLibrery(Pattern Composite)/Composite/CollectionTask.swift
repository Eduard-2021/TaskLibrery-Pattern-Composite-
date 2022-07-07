//
//  CollectionTask.swift
//  TaskLibrery(Pattern Composite)
//
//  Created by Eduard on 21.08.2021.
//

import UIKit

class CollectionTask: TaskProtocol {
    var task: String
    var collectionTask = [TaskProtocol]()
    
    init(task: String){
        self.task = task
    }
    
    func open() {
        
    }
}
