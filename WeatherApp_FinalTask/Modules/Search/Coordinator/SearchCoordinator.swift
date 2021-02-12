//
//  SearchCoordinator.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 19.01.2021..
//

import UIKit

class SearchCoordinator: Coordinator {
    weak var parent: CurrentWeatherCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var presenter: UIViewController
    
    init(presenter: UIViewController, navigationController: UINavigationController) {
        self.presenter = presenter
        self.navigationController = navigationController
    }
    
    deinit {
        print("search coordinator finished")
    }
    
    func start() {
        let repository = GeoNamesRepositoryImpl()
        let searchViewModel = SearchViewModel(repository: repository)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        searchViewController.coordinator = self
        searchViewController.modalPresentationStyle = .overCurrentContext
        presenter.present(searchViewController, animated: true, completion: nil)
    }
}

extension SearchCoordinator {
    func searchDidFinish() {
        presenter.dismiss(animated: true, completion: nil)
        parent?.childDidFinish(self)
    }
}
