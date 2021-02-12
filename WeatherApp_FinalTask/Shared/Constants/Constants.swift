//
//  Constants.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import Foundation
import MapKit

struct Constants {
    
    enum UnitsOfMeasurement: String {
        case pressure = "hPa"
        case humidity = "%"
        
        enum WindSpeed: String {
            case metric = "m/s"
            case imperial = "mph"
        }
    }
    
    static func pressureDisplay(of value: String) -> String {
        return value + " " + Constants.UnitsOfMeasurement.pressure.rawValue
    }
    
    static func humidityDisplay(of value: String) -> String {
        return value + " " + Constants.UnitsOfMeasurement.humidity.rawValue
    }
    
    static func windSpeedMetricDisplay(of value: String) -> String {
        return value + " " + Constants.UnitsOfMeasurement.WindSpeed.metric.rawValue
    }
    static func windSpeedImperialDisplay(of value: String) -> String {
        return value + " " + Constants.UnitsOfMeasurement.WindSpeed.imperial.rawValue
    }
    
    enum ConditionImages: String {
        case humidityIcon = "humidity_icon"
        case pressureIcon = "pressure_icon"
        case windIcon = "wind_icon"
    }
    
    let openWeatherAPIKey = "097d4b8d86a043c86ff8cc12d61b85d3"
    
    static func currentWeather(in city: String, units: String) -> String {
        return "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=\(units)&appid=097d4b8d86a043c86ff8cc12d61b85d3"
    }
    
    static func findNerbyPlace(_ latitude: Double, _ longitude: Double) -> String {
        return "http://api.geonames.org/findNearbyJSON?lat=\(latitude)&lng=\(longitude)&username=tgelesic"
    }
    
    static func cities(named cityName: String) -> String {
        return "http://api.geonames.org/searchJSON?q=\(cityName)&maxRows=10&username=tgelesic"
    }
}
