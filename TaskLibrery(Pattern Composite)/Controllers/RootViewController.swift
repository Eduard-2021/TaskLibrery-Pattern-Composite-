//
//  ViewController.swift
//  TaskLibrery(Pattern Composite)
//
//  Created by Eduard on 21.08.2021.
//

import UIKit

class RootViewController: UIViewController {

    let tableView = UITableView()
    var currentStateTask: TaskProtocol?
    var numberSelectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configTableView()
        configurenavigationController()
        navigationController?.delegate = self
    }
    
    private func configurenavigationController() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddTaskView))
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc func goToAddTaskView(){
        let viewForAddTask = AddTaskViewController()
        viewForAddTask.addTaskDelegate = self
        navigationController?.pushViewController(viewForAddTask, animated: true)
    }
    
    private func configureViewController() {
        let backgroudView = UIImageView(image: UIImage(named: "Фон"))
        backgroudView.contentMode = .scaleAspectFill
        let taskLabel = UILabel()
        taskLabel.text = "TASK"
        taskLabel.textColor = .black
        taskLabel.textAlignment = .center
        taskLabel.font = UIFont.boldSystemFont(ofSize: 80)
        let labreryLabel = UILabel()
        labreryLabel.text = "LABRERY"
        labreryLabel.textColor = UIColor(red: 118/255, green: 166/255, blue: 22/255, alpha: 1)
        labreryLabel.textAlignment = .center
        labreryLabel.font = UIFont.boldSystemFont(ofSize: 44)
        let generalNameTask = UILabel()
        generalNameTask.text = ClassTaskForShow.shared.taskForShow?.task
        generalNameTask.textColor = .white
        generalNameTask.backgroundColor = .darkGray
        generalNameTask.textAlignment = .center
        generalNameTask.font = UIFont.systemFont(ofSize: 18)
        tableView.alpha = 0.7

        self.view.insertSubview(backgroudView, at: 0)
        self.view.insertSubview(taskLabel, at: 1)
        self.view.insertSubview(labreryLabel, at: 2)
        self.view.insertSubview(generalNameTask, at: 3)
        self.view.insertSubview(tableView, at: 4)
        
        backgroudView.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        labreryLabel.translatesAutoresizingMaskIntoConstraints = false
        generalNameTask.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroudView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            backgroudView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            backgroudView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            backgroudView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            taskLabel.widthAnchor.constraint(equalToConstant: 221),
            taskLabel.heightAnchor.constraint(equalToConstant: 119),
            taskLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            taskLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 43),
            labreryLabel.widthAnchor.constraint(equalToConstant: 221),
            labreryLabel.heightAnchor.constraint(equalToConstant: 119),
            labreryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            labreryLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 90),
            generalNameTask.heightAnchor.constraint(equalToConstant: 38),
            generalNameTask.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            generalNameTask.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 193),
            generalNameTask.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            generalNameTask.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 239),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
    
    private func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TaskTableViewCell")
    }
    
}


extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRowsInSection = ClassTaskForShow.shared.taskForShow as? CollectionTask {
            return numberOfRowsInSection.collectionTask.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        if let collectionTask = ClassTaskForShow.shared.taskForShow as? CollectionTask {
            let currentTask = collectionTask.collectionTask[indexPath.row]
            if let currentTask = currentTask as? CollectionTask {
                cell.config(task:  currentTask.task, numberSubTask: currentTask.collectionTask.count)}
            else {
                cell.config(task:  currentTask.task, numberSubTask: 0)}
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskForShow = ClassTaskForShow.shared.taskForShow
        currentStateTask = taskForShow
        numberSelectedRow = indexPath.row
        if let taskForShow = taskForShow as? CollectionTask {
            ClassTaskForShow.shared.taskForShow = taskForShow.collectionTask[indexPath.row]
        }
        let viewForSubTask = RootViewController()
        navigationController?.pushViewController(viewForSubTask, animated: true)
    }
}


extension RootViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
                    if let previousView = toVC as? RootViewController,
                       let previousCurrentStateTask = previousView.currentStateTask as? CollectionTask,
                       let numberSelectedRow = previousView.numberSelectedRow {
                        if let previousCollectionTask = ClassTaskForShow.shared.taskForShow as? CollectionTask {
                            previousCurrentStateTask.collectionTask[numberSelectedRow] = previousCollectionTask
                        }

                        ClassTaskForShow.shared.taskForShow = previousCurrentStateTask
                        previousView.tableView.reloadData()
                        navigationController.delegate = previousView
                    }
            return nil
        default:
            return nil
        }
    }
}

extension RootViewController: AddedTaskDelegate {
    func addedTaskFunc(newTask: TaskProtocol) {
        if (ClassTaskForShow.shared.taskForShow as? CollectionTask) == nil {
            ClassTaskForShow.shared.taskForShow = CollectionTask(task: "\(ClassTaskForShow.shared.taskForShow!.task)")
        }
        if let currentTask = ClassTaskForShow.shared.taskForShow as? CollectionTask {
            currentTask.collectionTask.append(newTask) }
        tableView.reloadData()
    }
}
