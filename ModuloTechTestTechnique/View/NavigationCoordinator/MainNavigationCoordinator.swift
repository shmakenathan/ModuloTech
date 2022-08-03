//
//  MainNavigationCoordinator.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 03/08/2022.
//

import Foundation
import UIKit

final class MainNavigationCoordinator: NavigationCoordinator {
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    let navigationController: UINavigationController
    
    func eventOccurred(eventType: NavigationEventType) {
        switch eventType {
        case .deviceInListTapped(let viewModelTapped):
            let destinationViewController = DeviceDetailsViewController()
            destinationViewController.viewModel = viewModelTapped
            navigationController.pushViewController(destinationViewController, animated: true)
        }
    }
    
    func start() {
        let rootViewController = DeviceListViewController()
        rootViewController.navigationCoordinator = self
        navigationController.setViewControllers([rootViewController], animated: true)
    }
}
