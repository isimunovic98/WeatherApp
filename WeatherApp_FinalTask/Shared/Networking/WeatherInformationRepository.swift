//
//  CurrentWeatherRepository.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 15.01.2021..
//

import Foundation
import Combine

protocol WeatherInformationRepository {
    func getCurrentWeatherInformation(in city: String) -> AnyPublisher<CurrentWeather, NetworkError>
}

class CurrentWeatherRepositoryImpl: WeatherInformationRepository {
    
    func getCurrentWeatherInformation(in city: String) -> AnyPublisher<CurrentWeather, NetworkError> {
        return RestManager
            .requestObservable(url: Constants.currentWeather(in: city))
    }
}
