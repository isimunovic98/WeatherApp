//
//  Defaults.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 17.01.2021..
//

import Foundation

enum Units: String {
    case metric = "metric"
    case imperial = "imperial"
}

enum DefaultsKey: String {
    case selectedCity = "selectedCity"
    case selectedUnits = "selectedUnits"
}

struct Defaults {
    private static let userDefault = UserDefaults.standard
    
    static func saveCity(_ city: String) {
        userDefault.set(city, forKey: DefaultsKey.selectedCity.rawValue)
    }
    
    static func getSelectedCity() -> String {
        guard let selectedCity = userDefault.string(forKey: DefaultsKey.selectedCity.rawValue) else {
            return "Vienna"
        }
        
        return selectedCity
    }
    
    static func getSelectedUnits() -> String {
        guard let selectedUnits = userDefault.string(forKey: DefaultsKey.selectedUnits.rawValue) else {
            return Units.metric.rawValue
        }
        
        return selectedUnits
    }
    
    static func saveUnits(_ units: String) {
        userDefault.set(units, forKey: DefaultsKey.selectedUnits.rawValue)
    }
    
    
}
