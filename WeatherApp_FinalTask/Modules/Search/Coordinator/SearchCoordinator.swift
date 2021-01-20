//
//  SearchCoordinator.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 19.01.2021..
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var presenter: UIViewController
    
    init(presenter: UIViewController, navigationController: UINavigationController) {
        self.presenter = presenter
        self.navigationController = navigationController
    }
    
    func start() {
        let repository = GeoNamesRepositoryImpl()
        let searchViewModel = SearchViewModel(repository: repository)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        searchViewController.modalPresentationStyle = .fullScreen
        presenter.present(searchViewController, animated: true, completion: nil)
    }
}
