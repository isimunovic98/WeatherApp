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
    
    let loadData  = PassthroughSubject<Void, Never>()
    let screenDataReadyPublisher = PassthroughSubject<Void, Never>()
    let deleteButtonTapped = PassthroughSubject<Void, Never>()
    
}

extension SettingsViewModel {
    func initializeScreenData(for subject: PassthroughSubject<Void, Never>)-> AnyCancellable {
        return subject.map({
            return CoreDataManager.fetchCities()
        })
        .sink(receiveValue: { [unowned self] screenData in
            self.screenData = screenData
            screenDataReadyPublisher.send()
        })
    
    }
}
