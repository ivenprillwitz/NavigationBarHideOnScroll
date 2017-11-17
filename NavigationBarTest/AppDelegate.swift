//
//  AppDelegate.swift
//  NavigationBarTest
//
//  Created by Iven Prillwitz on 17.11.17.
//  Copyright © 2017 Iven Prillwitz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        let viewcontroller = ViewController()
        let navigationController = UINavigationController(rootViewController: viewcontroller)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

