//
//  QuestionViewController.swift
//  TaskLibrery(Pattern Composite)
//
//  Created by Eduard on 21.08.2021.
//

import UIKit

protocol AddedTaskDelegate: AnyObject {
    func addedTaskFunc(newTask: TaskProtocol)
}

class AddTaskViewController: UIViewController {

    let addButton = UIButton()
    let textView = UITextView()
    var addTaskDelegate: RootViewController?
    var newTask = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureAddButton()
        textView.delegate = self
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
        let pleaseAddTaskLabel = UILabel()
        pleaseAddTaskLabel.text = "Please add task"
        pleaseAddTaskLabel.textColor = .white
        pleaseAddTaskLabel.backgroundColor = .darkGray
        pleaseAddTaskLabel.textAlignment = .center
        pleaseAddTaskLabel.font = UIFont.systemFont(ofSize: 18)
        textView.text = nil
        textView.font = UIFont.systemFont(ofSize: 15)
        addButton.tintColor = .white
        addButton.backgroundColor = .darkGray
        addButton.titleLabel!.textAlignment = .center
        addButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 15)
        addButton.setTitle("Add and return", for: [])
        addButton.isHidden = true
    
        self.view.insertSubview(backgroudView, at: 0)
        self.view.insertSubview(taskLabel, at: 1)
        self.view.insertSubview(labreryLabel, at: 2)
        self.view.insertSubview(pleaseAddTaskLabel, at: 3)
        self.view.insertSubview(textView, at: 4)
        self.view.insertSubview(addButton, at: 5)
        
        backgroudView.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        labreryLabel.translatesAutoresizingMaskIntoConstraints = false
        pleaseAddTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            pleaseAddTaskLabel.heightAnchor.constraint(equalToConstant: 38),
            pleaseAddTaskLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 194),
            pleaseAddTaskLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 47),
            pleaseAddTaskLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -47),
            textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 247),
            textView.heightAnchor.constraint(equalToConstant: 240),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 47),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -47),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 513),
            addButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 124),
            addButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -124),
        ])
    }
    private func configureAddButton(){
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    @objc func addButtonPressed(){
        addTaskDelegate?.addedTaskFunc(newTask: OneTask(task: newTask))
        navigationController?.popViewController(animated: true)
    }
}

extension AddTaskViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != nil && textView.text != "" {
            addButton.isHidden = false
        }
        else {
            addButton.isHidden = true
        }
        newTask = textView.text ?? ""
    }
}
