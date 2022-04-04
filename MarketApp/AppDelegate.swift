//
//  AppDelegate.swift
//  MarketApp
//
//  Created by MacBook on 22/12/2021.
//

import UIKit
import Firebase
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        initializePayPal()
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
    func initializePayPal() {
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction : "ASJcs7jafQ7EFcvYZmKbmbDqeMk1MyH_AD1WV3xiIXRBowsPlVg8rUGK2sqctQPfOglxluxpVEU16mSq",PayPalEnvironmentSandbox : "sb-a8kyb15564106@business.example.com"])
    }
    


}

