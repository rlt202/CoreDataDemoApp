//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Даниил Никулин on 25.11.2020.
//

import UIKit
import CoreData

class TaskListViewController: UITableViewController {
    
     let context = StorageManager.manage.persistentContainer.viewContext
    
     let cellID = "cell"
     var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func addNewTask() {
        
        showAlert()
    }
}

extension TaskListViewController {
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Новая задача",
            message: "Что хотите на этот раз?",
            preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let task = alert.textFields?.first?.text,
                 !task.isEmpty else { return }
            
            self.save(task)
            
        }
        
        let cancelAction = UIAlertAction(title: "Назад", style: .destructive)
        
        alert.addTextField()
        alert.textFields?.first?.keyboardAppearance = .dark
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func editingAlert(at row: Int) {
        let alert = UIAlertController(
            title: "Изменить задачу",
            message: "Введите новую задачу",
            preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Обновить", style: .default) { _ in
            guard let task = alert.textFields?.first?.text,
                !task.isEmpty else { return }
            
            self.update(at: row, newTaskName: task)
        }
        
        let cancelAction = UIAlertAction(title: "Назад", style: .destructive)
        
        alert.addTextField()
        alert.textFields?.first?.keyboardAppearance = .dark
        alert.textFields?.first?.text = tasks[row].name
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

