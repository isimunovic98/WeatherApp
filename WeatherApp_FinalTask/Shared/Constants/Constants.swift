//
//  Constants.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import Foundation

struct Constants {
    let openWeatherAPIKey = "097d4b8d86a043c86ff8cc12d61b85d3"
    
    static func currentWeather(in city: String) -> String {
        return "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=097d4b8d86a043c86ff8cc12d61b85d3"
    }
}
