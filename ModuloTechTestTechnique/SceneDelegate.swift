//
//  SceneDelegate.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 25/07/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // TODO: change once test is done
      
        let navigationRootViewController = DeviceListViewController() // to uncomment
        // let navigationRootViewController = CountViewController() // to comment
        
        let windowRootViewController = UINavigationController(rootViewController: navigationRootViewController)
        window?.rootViewController = windowRootViewController
        window?.makeKeyAndVisible()
    }


    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

