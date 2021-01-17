//
//  CurrentWeatherViewModel.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 14.01.2021..
//

import Foundation
import Combine

class CurrentWeatherViewModel {
    private var cityName: String
    
    var currentWeatherRepository: WeatherInformationRepository
    
    var screenData: WeatherInformation?
    
    let loadData = CurrentValueSubject<Bool, NetworkError>(true)
    var shouldShowBlurView = PassthroughSubject<Bool, Never>()
    let screenDataReady = PassthroughSubject<Void, Never>()
    
    public init(cityName: String, repository: WeatherInformationRepository) {
        self.cityName = cityName
        self.currentWeatherRepository = repository
    }
}

extension CurrentWeatherViewModel {
    func initializeScreenData(for subject: CurrentValueSubject<Bool, NetworkError>) -> AnyCancellable {
        return subject.flatMap {[unowned self] (value) -> AnyPublisher<CurrentWeather, NetworkError> in
            self.shouldShowBlurView.send(value)
            return self.currentWeatherRepository.getCurrentWeatherInformation(in: self.cityName)
        }
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: RunLoop.main)
        .map({ [unowned self] (weatherModel) -> WeatherInformation in
            return WeatherInformation(cityName: self.cityName, weatherModel: weatherModel)
        })
        .sink(receiveCompletion: { _ in
            
        }, receiveValue: {[unowned self] data in
            self.screenData = data
            self.screenDataReady.send()
            self.shouldShowBlurView.send(false)
        })


        
    }
}
