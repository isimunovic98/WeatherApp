//
//  SettingsCoordinator.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit

class SettingsCoordinator: Coordinator {
    weak var parent: CurrentWeatherCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    var backgroundImage: UIImage
    
    init(navigationController: UINavigationController, backgroundImage: UIImage) {
        self.navigationController = navigationController
        self.backgroundImage = backgroundImage
    }
    
    deinit {
        print("settings coordinator finished")
    }
    
    func start() {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel, backgroundImage: backgroundImage)
        viewController.coordinator = self
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func settingsDidFinish() {
        parent?.childDidFinish(self)
    }
}
