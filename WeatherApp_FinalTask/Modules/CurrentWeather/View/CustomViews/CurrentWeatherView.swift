//
//  CurrentWeatherView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import UIKit
import SnapKit

class CurrentWeatherView: UIView {
    
    //MARK: Properties
    let currentTemperatureView: TemperatureView =  {
        let view = TemperatureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(25)
        return label
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        return label
    }()
    
    let dividorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let dailyLowTemperatureView: TemperatureView =  {
        let view = TemperatureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dailyHighTemperatureView: TemperatureView =  {
        let view = TemperatureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let conditionsStackView: WeatherConditionsStackView = {
        let view = WeatherConditionsStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: - UI Setup
private extension CurrentWeatherView {
    func setupView() {
        let views = [currentTemperatureView,
                     weatherDescriptionLabel,
                     cityNameLabel,
                     dividorLineView,
                     dailyLowTemperatureView,
                     dailyHighTemperatureView,
                     conditionsStackView]
        
        addSubviews(views)
        setupLayout()
    }
    
    func setupLayout() {
        currentTemperatureView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(50)
            make.centerX.equalTo(self)
            make.height.equalTo(150)
            make.width.equalTo(300)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(currentTemperatureView.snp.bottom)
            make.centerX.equalTo(self)
            
        }
        
        cityNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(50)
            make.centerX.equalTo(self)
        }
        
        dividorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(20)
            make.height.equalTo(100)
            make.width.equalTo(2)
            make.centerX.equalTo(self)
        }
        
        dailyLowTemperatureView.snp.makeConstraints { (make) in
            make.size.equalTo(130)
            make.centerY.equalTo(dividorLineView)
            make.trailing.equalTo(dividorLineView.snp.leading)
        }
        
        dailyHighTemperatureView.snp.makeConstraints { (make) in
            make.size.equalTo(130)
            make.centerY.equalTo(dividorLineView)
            make.leading.equalTo(dividorLineView.snp.trailing)
        }
        
        conditionsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(dividorLineView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(150)
        }
    }
}

extension CurrentWeatherView {
    public func configure(with weather: WeatherInformation) {
        setupTemperatureUnits()
        currentTemperatureView.temperatureLabel.text = weather.currentTemperature
        weatherDescriptionLabel.text = weather.weatherDescription
        cityNameLabel.text = weather.cityName
        dailyLowTemperatureView.temperatureLabel.text = weather.tempMin
        dailyHighTemperatureView.temperatureLabel.text = weather.tempMax
        conditionsStackView.humidityConditionView.conditionValueLabel.text = weather.humidity
        conditionsStackView.pressureConditionView.conditionValueLabel.text = weather.pressure
        conditionsStackView.windSpeedConditionView.conditionValueLabel.text = weather.windSpeed
        
        conditionsStackView.pressureConditionView.isHidden = true
    }
    
    private func setupTemperatureUnits() {
        let selectedUnits = Defaults.getSelectedUnits()
        
        switch selectedUnits {
        case Units.imperial.rawValue:
            currentTemperatureView.temperatureUnitLabel.text = TemperatureUnit.imperial.rawValue
            dailyLowTemperatureView.temperatureUnitLabel.text = TemperatureUnit.imperial.rawValue
            dailyHighTemperatureView.temperatureUnitLabel.text = TemperatureUnit.imperial.rawValue
        default:
            currentTemperatureView.temperatureUnitLabel.text = TemperatureUnit.metric.rawValue
            dailyLowTemperatureView.temperatureUnitLabel.text = TemperatureUnit.metric.rawValue
            dailyHighTemperatureView.temperatureUnitLabel.text = TemperatureUnit.metric.rawValue
        }
    }
}
