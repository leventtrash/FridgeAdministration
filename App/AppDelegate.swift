//
//  AppDelegate.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 13.05.25.
//


// AppDelegate.swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let foodItemListVC = FoodItemListViewController()
        let navigationController = UINavigationController(rootViewController: foodItemListVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
