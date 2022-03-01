//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 18.02.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }

    func createFeedNavigationController() -> UINavigationController {
        let feedVC = FeedVC()
        feedVC.title = "Feed"

        feedVC.tabBarItem.image = UIImage(named: "icons8-Material Filled-List")
        feedVC.tabBarItem.selectedImage = UIImage(named: "icons8-Material Two Tone-89421-50-ffffff")

        return UINavigationController(rootViewController: feedVC)
    }
    
    func createProfileNavigationController() -> UINavigationController {
        let profileVC = ProfileVC()
        profileVC.title = "Profile"

        profileVC.tabBarItem.image = UIImage(named: "icons8-iOS Filled-33901-50-ffffff")
        profileVC.tabBarItem.selectedImage = UIImage(named: "icons8-iOS-Cat Profile")

        return UINavigationController(rootViewController: profileVC)
    }

    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()

        // appearance = overall
        UITabBar.appearance().tintColor = .systemPink
        tabBar.viewControllers = [createFeedNavigationController(), createProfileNavigationController()]

        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
