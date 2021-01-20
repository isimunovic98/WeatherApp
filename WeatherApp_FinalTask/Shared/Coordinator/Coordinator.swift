//
//  Coordinator.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
