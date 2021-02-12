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
        print(navigationController)
        let weatherRepository = CurrentWeatherRepositoryImpl()
        let geoNamesRepository = GeoNamesRepositoryImpl()
        let viewModel = CurrentWeatherViewModel(weatherRepository: weatherRepository, geoNamesRepository: geoNamesRepository)
        let viewController = CurrentWeatherViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension CurrentWeatherCoordinator {
    func childDidFinish(_ child: Coordinator?) {
        if let _ = child as? SettingsCoordinator {
            navigationController.popViewController(animated: true)
        }
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
    
    func goToSettings(with backgroundImage: UIImage) {
        let child = SettingsCoordinator(navigationController: navigationController, backgroundImage: backgroundImage)
        child.parent = self
        childCoordinators.append(child)
        child.start()
    }
    
    func presentSearchScreen(on viewController: UIViewController) {
        let child = SearchCoordinator(presenter: viewController,navigationController: navigationController)
        child.parent = self
        childCoordinators.append(child)
        child.start()
    }
}
