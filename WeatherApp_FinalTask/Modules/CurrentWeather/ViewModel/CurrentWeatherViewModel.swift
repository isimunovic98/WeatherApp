//
//  CurrentWeatherViewModel.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 14.01.2021..
//

import Foundation
import Combine
import MapKit

class CurrentWeatherViewModel {
    //MARK: Properties
    var currentWeatherRepository: WeatherInformationRepository
    var geoNamesRepository: GeoNamesRepository
    
    var screenData: WeatherInformation?
    
    var loadData = CurrentValueSubject<Bool, Never>(true)
    var shouldShowBlurView = PassthroughSubject<Bool, Never>()
    var screenDataReadyPublisher = PassthroughSubject<Void, Never>()
    var errorPublisher = PassthroughSubject<String?, Never>()
    var useLocationPublisher = PassthroughSubject<CLLocationCoordinate2D, Never>()
    
    //MARK: Init
    public init(weatherRepository: WeatherInformationRepository, geoNamesRepository: GeoNamesRepository) {
        self.currentWeatherRepository = weatherRepository
        self.geoNamesRepository = geoNamesRepository
    }
}

//MARK: - Public Methods
extension CurrentWeatherViewModel {
    func initializeScreenData(for subject: CurrentValueSubject<Bool, Never>) -> AnyCancellable {
        return subject.flatMap {[unowned self] (value) -> AnyPublisher<CurrentWeather, NetworkError> in
            self.shouldShowBlurView.send(value)
            return self.currentWeatherRepository.getCurrentWeatherInformation()
        }
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: RunLoop.main)
        .map({ [unowned self] weatherModel -> WeatherInformation in
            return self.createScreenData(from: weatherModel)
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
    
    func attachLocationListener(subject: PassthroughSubject<CLLocationCoordinate2D, Never>) -> AnyCancellable {
        return subject
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .flatMap({ [unowned self] coordinates -> AnyPublisher<GeoNames, NetworkError> in
                let ltd = coordinates.latitude
                let lng = coordinates.longitude
                return self.geoNamesRepository.getNerbyPlace(ltd, lng)
            })
            .map({ [unowned self] (geoNames) in
                return self.updateCurrentLocation(with: geoNames)
            })
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorPublisher.send(error.localizedDescription)
                }
            }, receiveValue: {[unowned self] data in
                self.loadData.send(true)
            })

    }
    
    func createScreenData(from weatherModel: CurrentWeather) -> WeatherInformation {
        let selectedUnits = Defaults.getSelectedUnits()
        let pressureIsHidden = Defaults.pressureIsHidden()
        let windSpeedIsHidden = Defaults.windSpeedIsHidden()
        let humidityIsHidden = Defaults.humidityIsHidden()
        return WeatherInformation(weatherModel: weatherModel,
                                  selectedUnits: selectedUnits,
                                  pressureIsShown: pressureIsHidden,
                                  windSpeedeIsShown: windSpeedIsHidden,
                                  humidityeIsShown: humidityIsHidden)
    }
    
        func updateCurrentLocation(with geoNames: GeoNames) {
            for item in geoNames.results {
                Defaults.saveCity(item.name)
                CoreDataManager.save(named: item.name)
            }
        }
}
