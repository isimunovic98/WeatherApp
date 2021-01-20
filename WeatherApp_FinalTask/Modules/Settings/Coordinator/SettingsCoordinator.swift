//
//  SettingsCoordinator.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit

class SettingsCoordinator: Coordinator {
    weak var parent: AppCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToWeatherInformation() {
        parent?.goToWeatherInformation()
    }
}
