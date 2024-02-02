//
//  SceneDelegate.swift
//  Apple Store
//
//  Created by Gamid Gapizov on 24.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // MARK: Setting View Controllers
        let window = UIWindow(windowScene: windowScene)
        let shopVC = ShopVC()
        let accountVC = AccountVC()
        let searchVC = SearchVC()
        let bagVC = BagVC()
        let cardVC = CardVC()
        
        
        // MARK: Setting NavigationViewControllers
        let shopNavVC = UINavigationController(rootViewController: shopVC)
        let shopTabBarItem = UITabBarItem(title: "Shop", image: .init(systemName: "laptopcomputer"), tag: 0)
        shopNavVC.tabBarItem = shopTabBarItem
        shopNavVC.tabBarController?.tabBar.backgroundColor = .white
        shopNavVC.loadView()
        
        let accountNavVC = UINavigationController(rootViewController: accountVC)
        let accountTabBarItem = UITabBarItem(title: "Account", image: .init(systemName: "person.crop.circle"), tag: 1)
        accountNavVC.tabBarItem = accountTabBarItem
        accountNavVC.tabBarController?.tabBar.backgroundColor = .white
        accountNavVC.loadView()
        
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        let searchTabBarItem = UITabBarItem(title: "Search", image: .init(systemName: "magnifyingglass"), tag: 2)
        searchNavVC.tabBarItem = searchTabBarItem
        searchNavVC.tabBarController?.tabBar.backgroundColor = .black
        
        let bagNavVC = UINavigationController(rootViewController: bagVC)
        let bagTabBarItem = UITabBarItem(title: "Bag", image: .init(systemName: "bag.fill"), tag: 3)
        bagNavVC.tabBarItem = bagTabBarItem
        bagNavVC.tabBarController?.tabBar.backgroundColor = .black
        
        let cardNavVC = UINavigationController(rootViewController: cardVC)
        cardNavVC.loadViewIfNeeded()
        
        
        // MARK: Setting TabBarController
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.unselectedItemTintColor = .systemGray
        tabBarVC.setViewControllers([shopNavVC, accountNavVC, searchNavVC, bagNavVC], animated: true)
        tabBarVC.selectedViewController = shopNavVC
        
        
        // MARK: UIWindow settings
        self.window = window
        window.rootViewController = tabBarVC
        window.backgroundColor = .black
        window.tintColor = .systemBlue
        window.makeKeyAndVisible()
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

