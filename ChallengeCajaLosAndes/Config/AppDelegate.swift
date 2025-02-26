//
//  AppDelegate.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 3/01/25.
//

import UIKit
import IQKeyboardManagerSwift
import netfox
import Network

//MARK: Global var Check Network
var isOnline: Bool = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        NFX.sharedInstance().start() // in didFinishLaunchingWithOptions:
        
        //monitor internet
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                isOnline = true
                print("Si hay internet")
            }else{
                print("NOOOO hay internet")
                isOnline = false
            }
        }
        
        monitor.start(queue: queue)
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

