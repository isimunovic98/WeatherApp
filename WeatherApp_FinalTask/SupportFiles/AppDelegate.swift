//
//  AppDelegate.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 11.01.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let repo = CurrentWeatherRepositoryImpl()
        let viewModel = CurrentWeatherViewModel(cityName: "Vienna", repository: repo)
        let navigationController = UINavigationController(rootViewController: CurrentWeatherViewController(viewModel: viewModel))
        navigationController.navigationBar.isHidden = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

