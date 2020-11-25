//
//  CoreDataMethods.swift
//  CoreDataDemo
//
//  Created by Даниил Никулин on 25.11.2020.
//

import UIKit
import CoreData

extension TaskListViewController {
    
     func fetchData() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            tasks = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error {
            print(error)
        }
    }
    
     func save(_ taskName: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        
        task.name = taskName
        tasks.append(task)
        
        let cellIndex = IndexPath(row: tasks.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
    }
    
    func update(at index: Int, newTaskName: String) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            let tasks = try context.fetch(fetchRequest)
            let taskToUpdate = tasks[index] as NSManagedObject
            taskToUpdate.setValue(newTaskName, forKey: "name")
            
            self.tasks[index].name = newTaskName
            self.tableView.reloadRows(
                at: [IndexPath(row: index, section: 0)],
                with: .automatic)
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        } catch let error {
            print(error)
        }
    }
    
     func delete(_ task: Task, indexPath: IndexPath) {
        context.delete(task)
        do {
            try context.save()
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error {
            print(error)
        }
    }
}
