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
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .medium)
        button.setImage(UIImage(systemName: "gearshape", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "search"
        searchBar.isTranslucent = true
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .white
        return searchBar
    }()
    
    let currentTemperatureView: TemperatureView =  {
        let view = TemperatureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.temperatureLabel.font = .systemFont(ofSize: 80)
        view.temperatureUnitLabel.font = .systemFont(ofSize: 80)
        return view
    }()
    
    let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.textColor = .white
        return label
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(25)
        label.textColor = .white
        return label
    }()
    
    let dividorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let dailyLowTemperatureView: TemperatureView =  {
        let view = TemperatureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.temperatureLabel.font = .systemFont(ofSize: 40)
        view.temperatureUnitLabel.font = .systemFont(ofSize: 40)
        return view
    }()
    
    let dailyHighTemperatureView: TemperatureView =  {
        let view = TemperatureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.temperatureLabel.font = .systemFont(ofSize: 40)
        view.temperatureUnitLabel.font = .systemFont(ofSize: 40)
        return view
    }()
    
    let conditionsStackView: WeatherConditionsStackView = {
        let view = WeatherConditionsStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Init
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
        let views = [backgroundImageView,
                     currentTemperatureView,
                     weatherDescriptionLabel,
                     cityNameLabel,
                     dividorLineView,
                     dailyLowTemperatureView,
                     dailyHighTemperatureView,
                     conditionsStackView,
                     settingsButton,
                     searchBar]
        
        addSubviews(views)
        setupLayout()
    }
    
    func setupLayout() {
        backgroundImageView.snp.makeConstraints{ (make) in
            make.edges.equalTo(self)
        }
        
        cityNameLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
        }
        
        settingsButton.snp.makeConstraints { (make) in
            make.leading.bottom.equalTo(self).inset(30)
            make.size.equalTo(40)
        }
        
        searchBar.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(settingsButton)
            make.leading.equalTo(settingsButton.snp.trailing)
            make.trailing.equalTo(self).inset(10)
        }
        
        dividorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(20)
            make.bottom.equalTo(conditionsStackView.snp.top)
            make.width.equalTo(2)
            make.centerX.equalTo(self)
        }

        dailyLowTemperatureView.snp.makeConstraints { (make) in
            make.height.equalTo(dividorLineView)
            make.leading.equalTo(self).inset(15)
            make.centerY.equalTo(dividorLineView)
            make.trailing.equalTo(dividorLineView.snp.leading)
        }

        dailyHighTemperatureView.snp.makeConstraints { (make) in
            make.height.equalTo(dividorLineView)
            make.trailing.equalTo(self).inset(15)
            make.centerY.equalTo(dividorLineView)
            make.leading.equalTo(dividorLineView.snp.trailing)
        }
        
        currentTemperatureView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.centerX.equalTo(self)
            make.height.equalTo(150)
            make.width.equalTo(300)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(currentTemperatureView.snp.bottom).offset(15)
            make.centerX.equalTo(self)
        }

        conditionsStackView.snp.makeConstraints { (make) in
            make.bottom.equalTo(searchBar.snp.top).offset(-50)
            make.centerX.equalTo(self)
        }
    }
}

extension CurrentWeatherView {
    public func configure(with weather: WeatherInformation) {
        currentTemperatureView.configure(temperature: weather.currentTemperature)
        
        cityNameLabel.text = weather.cityName.uppercased()
        
        weatherDescriptionLabel.text = weather.weatherDescription

        dailyLowTemperatureView.configure(temperature: weather.tempMin)
        dailyHighTemperatureView.configure(temperature: weather.tempMax)
        
        conditionsStackView.configure(with: weather)

        
        setTemperatureUnits(from: weather.selectedUnits)
        setupConditions(from: weather)
        
    }
    
    private func setTemperatureUnits(from selectedUnits: String) {
        var unitIndicator: String
        switch selectedUnits {
        case Units.imperial.rawValue:
            unitIndicator = TemperatureUnit.imperial.rawValue
        default:
            unitIndicator = TemperatureUnit.metric.rawValue
        }
        
        currentTemperatureView.temperatureUnitLabel.text = unitIndicator
        dailyLowTemperatureView.temperatureUnitLabel.text = unitIndicator
        dailyHighTemperatureView.temperatureUnitLabel.text = unitIndicator
    }
    
    private func setupConditions(from weatherInformation: WeatherInformation) {
        conditionsStackView.pressureConditionView.isHidden = weatherInformation.pressureIsHidden
        conditionsStackView.windSpeedConditionView.isHidden = weatherInformation.windSpeedIsHidden
        conditionsStackView.humidityConditionView.isHidden = weatherInformation.humidityIsHidden
    }
}
