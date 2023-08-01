//
//  AppDelegate.swift
//  Sample
//
//  Created by APPLE on 03/07/23.
//

import UIKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppCenter.start(withAppSecret: "784cd1aa-b410-433c-9088-06f85915b20e", services: [Crashes.self])
        // Override point for customization after application launch.
        return true
    }

    

   


}

