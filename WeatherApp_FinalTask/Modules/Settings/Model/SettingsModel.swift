//
//  SettingsModel.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 08.02.2021..
//

import Foundation

struct Conditions {
    var pressureIsSelected: Bool
    var windSpeedIsSelected: Bool
    var humidityIsSelected: Bool
}
struct SettingsModel {
    var savedCities: [String]
    var selectedUnit: String
    var selectedConditions: Conditions
    
    init() {
        self.savedCities = []
        self.selectedUnit = "metric"
        self.selectedConditions = Conditions(pressureIsSelected: false, windSpeedIsSelected: false, humidityIsSelected: false)
    }
    
    init(savedCities: [String], selectedUnit: String, selectedConditions: Conditions) {
        self.savedCities = savedCities
        self.selectedUnit = selectedUnit
        self.selectedConditions = selectedConditions
    }
}
