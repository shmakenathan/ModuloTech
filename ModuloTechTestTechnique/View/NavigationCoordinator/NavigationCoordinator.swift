//
//  NavigationCoordinator.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 02/08/2022.
//

import Foundation
import UIKit

protocol NavigationCoordinator {
    var navigationController: UINavigationController { get }
    
    func eventOccurred(eventType: NavigationEventType)
    func start()
}




