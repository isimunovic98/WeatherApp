//
//  WeatherInfo.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 15.01.2021..
//

import Foundation

struct WeatherInformation {
    var cityName: String
    var weatherId: Int
    var icon: String
    var weatherDescription: String
    var currentTemperature: String
    var tempMin: String
    var tempMax: String
    var pressure: String
    var humidity: String
    var windSpeed: String
    
    init(weatherModel: CurrentWeather) {
        self.cityName = Defaults.getSelectedCity()
        self.icon = weatherModel.description[0].icon
        self.weatherId = weatherModel.description[0].id
        self.weatherDescription = weatherModel.description[0].description
        self.currentTemperature = String(format: "%.1f", weatherModel.temperature.currentTemperature)
        self.tempMin = String(format: "%.1f", weatherModel.temperature.tempMin)
        self.tempMax = String(format: "%.1f", weatherModel.temperature.tempMax)
        self.pressure = String(weatherModel.temperature.pressure)
        self.humidity = String(weatherModel.temperature.humidity)
        self.windSpeed = String(weatherModel.wind.speed)
    }
}
