//
//  Constants.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import Foundation

struct Constants {
    
    enum ConditionImages: String {
        case humidityIcon = "humidity_icon"
        case pressureIcon = "pressure_icon"
        case windIcon = "wind_icon"
    }
    let openWeatherAPIKey = "097d4b8d86a043c86ff8cc12d61b85d3"
    
    static func currentWeather(in city: String, units: String) -> String {
        return "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=\(units)&appid=097d4b8d86a043c86ff8cc12d61b85d3"
    }
    
    static func cities(named cityName: String) -> String {
        return "https://secure.geonames.org/searchJSON?name_startsWith=\(cityName)&maxRows=10&username=isimunovic"
    }
}
