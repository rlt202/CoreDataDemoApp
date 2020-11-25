//
//  AppDelegate.swift
//  CoreDataDemo
//
//  Created by Даниил Никулин on 25.11.2020.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: TaskListViewController())
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.manage.saveContext()
    }
}

