//
//  AppCoordinator.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let child = CurrentWeatherCoordinator(navigationController: navigationController)
        child.parent = self
        childCoordinators.append(child)
        child.start()
    }
    
    func goToSettings() {
        let child = SettingsCoordinator(navigationController: navigationController)
        child.parent = self
        childCoordinators.append(child)
        child.start()
    }
    
    func goToWeatherInformation() {
        navigationController.popViewController(animated: true)
    }
}
