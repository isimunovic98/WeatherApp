//
//  CurrentWeatherViewModel.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 14.01.2021..
//

import Foundation
import Combine

class CurrentWeatherViewModel {
    var currentWeatherRepository: WeatherInformationRepository
    
    var screenData: WeatherInformation?
    
    let loadData = CurrentValueSubject<Bool, NetworkError>(true)
    var shouldShowBlurView = PassthroughSubject<Bool, Never>()
    let screenDataReady = PassthroughSubject<Void, Never>()
    
    public init(repository: WeatherInformationRepository) {
        self.currentWeatherRepository = repository
    }
}

extension CurrentWeatherViewModel {
    func initializeScreenData(for subject: CurrentValueSubject<Bool, NetworkError>) -> AnyCancellable {
        return subject.flatMap {[unowned self] (value) -> AnyPublisher<CurrentWeather, NetworkError> in
            self.shouldShowBlurView.send(value)
            return self.currentWeatherRepository.getCurrentWeatherInformation()
        }
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: RunLoop.main)
        .map({ (weatherModel) -> WeatherInformation in
            return WeatherInformation(weatherModel: weatherModel)
        })
        .sink(receiveCompletion: { _ in
            
        }, receiveValue: {[unowned self] data in
            self.screenData = data
            self.screenDataReady.send()
            self.shouldShowBlurView.send(false)
        })
    }
    
    
}

private extension CurrentWeatherViewModel {
    
}
