//
//  GoeNamesRepository.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 19.01.2021..
//

import Foundation
import Combine

protocol GeoNamesRepository{
    func getCities(named cityName: String) -> AnyPublisher<GeoNames, NetworkError>
}

class GeoNamesRepositoryImpl: GeoNamesRepository {
    
    func getCities(named cityName: String) -> AnyPublisher<GeoNames, NetworkError> {
        return RestManager
            .requestObservable(url: Constants.cities(named: cityName))
    }
}
