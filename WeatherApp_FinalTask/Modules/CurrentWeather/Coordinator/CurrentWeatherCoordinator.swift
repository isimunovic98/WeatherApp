//
//  CurrentWeatherCoordinator.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit

class CurrentWeatherCoordinator: Coordinator {
    weak var parent: AppCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let repository = CurrentWeatherRepositoryImpl()
        let viewModel = CurrentWeatherViewModel(repository: repository)
        let viewController = CurrentWeatherViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToSettings() {
        parent?.goToSettings()
    }
}
