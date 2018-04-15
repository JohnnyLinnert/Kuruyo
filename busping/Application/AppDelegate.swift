//
//  AppDelegate.swift
//  Kuruyo (previously busping)
//
//  Created by Johnny Linnert, beginning on 2016/09/28
//  With great help from Greg de Jonckheere and Jonathon Toon
//  Copyright © 2016-2017 Johnny Linnert. All rights reserved.
//

import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var token: String?
    var router: Router
    
    convenience override init() {
        let navigationRouter = NavigationRouter()
        self.init(router: navigationRouter)
    }
    
    init(router: Router) {
        self.router = router
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupInitialViewController()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]){
            (granted,error) in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            } else {
                print("User Notification permission denied: \(error?.localizedDescription ?? "default error")")
            }
        }
        
        return true
    }
    
    func setupInitialViewController() {
        window = UIWindow()
        router.showRootViewController()
        window?.rootViewController = router.rootViewController
        window?.makeKeyAndVisible()
    }
    
    //code to make a token string
    func tokenString(_ deviceToken:Data) -> String{
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes{
            token += String(format: "%02x",byte)
        }
        return token
    }
    
    // Successful registration and you have a token. Send the token to your provider, in this case the console for cut and paste.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Successful registration. Token is:")
        token = tokenString(deviceToken)
        print(tokenString(deviceToken))
    }
    
    // Failed registration. Explain why.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
}

