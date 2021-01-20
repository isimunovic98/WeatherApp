//
//  SettingsViewModel.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import Foundation
import Combine

class SettingsViewModel {
    //MARK: Properties
    var screenData: [String] = []
    
    let loadData  = CurrentValueSubject<Void?, Never>(nil)
    let screenDataReadyPublisher = PassthroughSubject<Void, Never>()
    let deleteButtonTapped = PassthroughSubject<Int, Never>()
    
}

extension SettingsViewModel {
    func initializeScreenData(for subject: CurrentValueSubject<Void?, Never>)-> AnyCancellable {
        return subject.map({ _ in 
            return CoreDataManager.fetchCities()
        })
        .subscribe(on: RunLoop.main)
        .receive(on: RunLoop.main)
        .sink(receiveValue: { [unowned self] screenData in
            self.screenData = screenData
            screenDataReadyPublisher.send()
        })
    }
    
    func attachDeleteButtonClickListener(listener: PassthroughSubject<Int, Never>) -> AnyCancellable {
        return listener
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .map({ [unowned self] index -> [String] in
                self.deleteCityAt(index, in: screenData)
            })
            .sink(receiveValue: {[unowned self] in
                self.screenData = $0
                self.screenDataReadyPublisher.send()
            })
    }
}

private extension SettingsViewModel {
    func deleteCityAt(_ index: Int, in data: [String]) -> [String] {
        var temp = data
        temp.remove(at: index)
        deleteCityFromCoreData(named: data[index])
        return temp
    }
    
    func deleteCityFromCoreData(named name: String) {
        CoreDataManager.deleteCity(named: name)
    }
}
