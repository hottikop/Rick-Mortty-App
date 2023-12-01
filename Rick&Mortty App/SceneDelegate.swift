//
//  SceneDelegate.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 17.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        window = UIWindow(windowScene: windowScene)
        
        UINavigationBar.appearance().barTintColor = R.color.screenColor()
        
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let navController = UINavigationController(rootViewController: PreviewViewController())
        navController.navigationBar.backgroundColor = R.color.screenColor()
        navController.navigationBar.tintColor = .white
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        
        
    }
}

