//
//  CurrentWeather.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import Foundation

struct Description: Codable {
    var main: String
    var description: String
}

struct Temperature: Codable {
    var currentTemperature: Float
    var tempMin: Float
    var tempMax: Float
    var pressure: Float
    var humidity: Float
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Codable {
    var speed: Float
}

struct CurrentWeather: Codable {
    var description: [Description]
    var temperature: Temperature
    var windSpeed: Wind
    
    enum CodingKeys: String, CodingKey {
        case description = "weather"
        case temperature = "main"
        case windSpeed = "wind"
    }
}

struct Test: Codable {
    var id: Int
}