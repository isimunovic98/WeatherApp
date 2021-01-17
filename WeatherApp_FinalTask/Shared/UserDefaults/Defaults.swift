//
//  Defaults.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 17.01.2021..
//

import Foundation

enum Units: String {
    case metric
    case imperial
}

enum DefaultsKey: String {
    case selectedCity
    case selectedUnits
    case pressureIsShown
    case windSpeedIsShown
    case humidityIsShown
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
    
    static func pressureIsHidden() -> Bool {
        return !userDefault.bool(forKey: DefaultsKey.pressureIsShown.rawValue)
    }
    
    static func windSpeedIsHidden() -> Bool {
        return !userDefault.bool(forKey: DefaultsKey.windSpeedIsShown.rawValue)
        
    }
    
    static func humidityIsHidden() -> Bool {
        return !userDefault.bool(forKey: DefaultsKey.humidityIsShown.rawValue)
           
    }
    
}
