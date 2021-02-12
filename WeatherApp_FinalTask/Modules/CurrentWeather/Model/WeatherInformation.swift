//
//  WeatherInfo.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 15.01.2021..
//

import Foundation

struct WeatherInformation: Codable {
    var cityName: String
    var weatherId: Int
    var dayNightIndicator: String
    var weatherDescription: String
    var currentTemperature: String
    var tempMin: String
    var tempMax: String
    var pressure: String
    var humidity: String
    var windSpeed: String
    var selectedUnits: String
    var pressureIsHidden: Bool
    var windSpeedIsHidden: Bool
    var humidityIsHidden: Bool
    
    init(weatherModel: CurrentWeather, selectedUnits: String, pressureIsShown: Bool, windSpeedeIsShown: Bool, humidityeIsShown: Bool) {
        self.cityName = Defaults.getSelectedCity()
        self.dayNightIndicator = weatherModel.description[0].icon
        self.weatherId = weatherModel.description[0].id
        self.weatherDescription = weatherModel.description[0].description
        self.currentTemperature = String(format: "%.1f", weatherModel.temperature.currentTemperature)
        self.tempMin = String(format: "%.1f", weatherModel.temperature.tempMin)
        self.tempMax = String(format: "%.1f", weatherModel.temperature.tempMax)
        self.pressure = String(weatherModel.temperature.pressure)
        self.humidity = String(weatherModel.temperature.humidity)
        self.windSpeed = String(weatherModel.wind.speed)
        self.selectedUnits = selectedUnits
        self.pressureIsHidden = pressureIsShown
        self.windSpeedIsHidden = windSpeedeIsShown
        self.humidityIsHidden = humidityeIsShown
    }
}
