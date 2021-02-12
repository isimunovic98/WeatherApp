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
    var screenData = SettingsModel()
    
    let loadData  = CurrentValueSubject<Void?, Never>(nil)
    let screenDataReadyPublisher = PassthroughSubject<Void, Never>()
    let deleteButtonTapped = PassthroughSubject<Int, Never>()
    
    let saveSelectedUnitPublisher = PassthroughSubject<Units, Never>()
    let saveSelectedConditionsPublisher = PassthroughSubject<Conditions, Never>()
}

extension SettingsViewModel {
    func initializeScreenData(for subject: CurrentValueSubject<Void?, Never>)-> AnyCancellable {
        return subject
            .map({ _ -> Conditions in
                let pressureIsSelected = !Defaults.pressureIsHidden()
                let windSpeedIsSelected = !Defaults.windSpeedIsHidden()
                let humidityIsSelected = !Defaults.humidityIsHidden()
                return Conditions(pressureIsSelected: pressureIsSelected, windSpeedIsSelected: windSpeedIsSelected, humidityIsSelected: humidityIsSelected)
            })
        .map({ conditions -> SettingsModel in
            let selectedUnit = Defaults.getSelectedUnits()
            let savedCities = CoreDataManager.fetchCities()
            return SettingsModel(savedCities: savedCities, selectedUnit: selectedUnit, selectedConditions: conditions)
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
            .map({ [unowned self] index -> SettingsModel in
                self.deleteCityAt(index, in: screenData)
            })
            .sink(receiveValue: {[unowned self] in
                self.screenData = $0
                self.screenDataReadyPublisher.send()
            })
    }
    
    func saveSelectedUnit(subject: PassthroughSubject<Units, Never>) -> AnyCancellable {
        return subject
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .map({ [unowned self] unit -> SettingsModel in
                self.saveUnit(unit, in: screenData)
            })
            .sink(receiveValue: { [unowned self] in
                self.screenData = $0
                self.screenDataReadyPublisher.send()
            })
    }
    
    func saveSelectedConditions(subject: PassthroughSubject<Conditions, Never>) -> AnyCancellable {
        return subject
            .map({ [unowned self] conditions -> SettingsModel in
                self.saveConditions(conditions, in: screenData)
            })
            .sink(receiveValue: { [unowned self] in
                self.screenData = $0
                self.screenDataReadyPublisher.send()
            })
    }
    
    func updateCurrentCity(with cityName: String) {
        Defaults.saveCity(cityName)
    }
}

private extension SettingsViewModel {
    func deleteCityAt(_ index: Int, in screenData: SettingsModel) -> SettingsModel {
        var temporary = screenData
        deleteCityFromCoreData(named: screenData.savedCities[index])
        temporary.savedCities.remove(at: index)
        return temporary
    }
    
    func deleteCityFromCoreData(named name: String) {
        CoreDataManager.deleteCity(named: name)
    }
    
    func saveUnit(_ unit: Units, in screenData: SettingsModel) -> SettingsModel {
        var temporary = screenData
        temporary.selectedUnit = unit.rawValue
        Defaults.saveUnits(unit.rawValue)
        return temporary
    }
    
    func saveConditions(_ conditions: Conditions, in screenData: SettingsModel) -> SettingsModel {
        var temporary = screenData
        temporary.selectedConditions = conditions
        Defaults.savePressureSelected(conditions.pressureIsSelected)
        Defaults.saveWindSpeedSelected(conditions.windSpeedIsSelected)
        Defaults.saveHumiditySelected(conditions.humidityIsSelected)
        return temporary
    }
}
