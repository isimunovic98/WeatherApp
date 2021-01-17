//
//  WeatherInfo.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 15.01.2021..
//

import Foundation

struct WeatherInformation {
    var cityName: String
    var weatherDescription: String
    var currentTemperature: String
    var tempMin: String
    var tempMax: String
    var pressure: String
    var humidity: String
    var windSpeed: String
    
    init(cityName: String, weatherModel: CurrentWeather) {
        self.cityName = cityName
        self.weatherDescription = weatherModel.description[0].description
        self.currentTemperature = String(weatherModel.temperature.currentTemperature)
        self.tempMin = String(weatherModel.temperature.tempMin)
        self.tempMax = String(weatherModel.temperature.tempMax)
        self.pressure = String(weatherModel.temperature.pressure)
        self.humidity = String(weatherModel.temperature.humidity)
        self.windSpeed = String(weatherModel.wind.speed)
    }
}
