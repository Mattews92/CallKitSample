//
//  AppDelegate.swift
//  CallKitSample
//
//  Created by Mathews on 09/07/18.
//  Copyright © 2018 mathews. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isCallOngoing = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if self.isCallOngoing {
            self.isCallOngoing = false
            self.loadCallerController()
        }
        PushKitDelegate.sharedInstance.registerPushKit()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if self.isCallOngoing {
            self.isCallOngoing = false
            self.loadCallerController()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if self.isCallOngoing {
            self.isCallOngoing = false
            self.loadCallerController()
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate {
    
    func setRootView(controller: UIViewController) {
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
    
    func loadRingerController() {
        let controller = UIStoryboard(name: "VideoCall", bundle: Bundle.main).instantiateViewController(withIdentifier: "RingerViewController") as! RingerViewController
        self.setRootView(controller: controller)
    }
    
    func loadCallerController() {
        let controller = UIStoryboard(name: "VideoCall", bundle: Bundle.main).instantiateViewController(withIdentifier: "VideoCallViewController") as! VideoCallViewController
        self.setRootView(controller: controller)
    }
}

