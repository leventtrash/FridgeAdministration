//
//  SceneDelegate.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 13.05.25.
//


// SceneDelegate.swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let foodItemListVC = FoodItemListViewController()
        let navigationController = UINavigationController(rootViewController: foodItemListVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
