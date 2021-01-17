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
    
    let loadData = CurrentValueSubject<Bool, Never>(true)
    var shouldShowBlurView = PassthroughSubject<Bool, Never>()
    var screenDataReadyPublisher = PassthroughSubject<Void, Never>()
    var errorPublisher = PassthroughSubject<String?, Never>()
    
    public init(repository: WeatherInformationRepository) {
        self.currentWeatherRepository = repository
    }
}

extension CurrentWeatherViewModel {
    func initializeScreenData(for subject: CurrentValueSubject<Bool, Never>) -> AnyCancellable {
        return subject.flatMap {[unowned self] (value) -> AnyPublisher<CurrentWeather, NetworkError> in
            self.shouldShowBlurView.send(value)
            return self.currentWeatherRepository.getCurrentWeatherInformation()
        }
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: RunLoop.main)
        .map({ (weatherModel) -> WeatherInformation in
            return WeatherInformation(weatherModel: weatherModel)
        })
        .sink(receiveCompletion: { [unowned self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.errorPublisher.send(error.localizedDescription)
            }
        }, receiveValue: {[unowned self] data in
            self.screenData = data
            self.screenDataReadyPublisher.send()
            self.shouldShowBlurView.send(false)
        })
    }
    
    
}

private extension CurrentWeatherViewModel {
    
}
