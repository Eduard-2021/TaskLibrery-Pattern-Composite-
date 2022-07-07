//
//  ClassTaskForShow.swift
//  TaskLibrery(Pattern Composite)
//
//  Created by Eduard on 21.08.2021.
//

import UIKit

class ClassTaskForShow {
    public static let shared = ClassTaskForShow()
    var previousTaskForShow: TaskProtocol?
    var taskForShow: TaskProtocol? {
        didSet {
            if oldValue == nil {
                allTasks = taskForShow
            }
            previousTaskForShow = oldValue
        }
    }
    var allTasks: TaskProtocol?
}
