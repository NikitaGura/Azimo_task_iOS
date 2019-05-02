//
//  AppDelegate.swift
//  Azimo_GitHub
//
//  Created by Nikita Gura on 4/30/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController = UINavigationController()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let firstViewController = FirstViewController()
        navController = UINavigationController(rootViewController: firstViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        
        window?.makeKeyAndVisible()
        return true
    }
}

