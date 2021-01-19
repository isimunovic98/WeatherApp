//
//  SearchViewModel.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 19.01.2021..
//

import Foundation
import Combine

class SearchViewModel {
    //MARK: Properties
    var geoNamesRepository: GeoNamesRepository
    
    var screenData: [String] = []
    
    let loadData = PassthroughSubject<String, Never>()
    var screenDataReadyPublisher = PassthroughSubject<Void, Never>()
    var errorPublisher = PassthroughSubject<String?, Never>()

    //MARK: init
    public init(repository: GeoNamesRepository) {
        self.geoNamesRepository = repository
    }
}

extension SearchViewModel {
    func initializeScreenData(for subject: PassthroughSubject<String, Never>) -> AnyCancellable {
        return subject
            .flatMap{ [unowned self] (value) -> AnyPublisher<GeoNames, NetworkError> in
                return self.geoNamesRepository.getCities(named: value)
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .map({ [unowned self] (geoNames) -> [String] in
                return self.createScreenData(from: geoNames)
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
            })
    }
}

private extension SearchViewModel {
    func createScreenData(from geoNamesModel: GeoNames) -> [String] {
        var screenData = [String]()
        
        for item in geoNamesModel.results {
            screenData.append(item.name)
        }
        
        return screenData
    }
}
