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
        label.text = "Weather description"
        label.font = label.font.withSize(25)
        return label
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "VIENNA"
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
    
    let dailyLowTemperature: TemperatureView =  {
        let view = TemperatureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dailyHighTemperature: TemperatureView =  {
        let view = TemperatureView()
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
        let views = [currentTemperatureView, weatherDescriptionLabel, cityNameLabel, dividorLineView, dailyLowTemperature, dailyHighTemperature]
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
        
        dailyLowTemperature.snp.makeConstraints { (make) in
            make.size.equalTo(80)
            make.centerY.equalTo(dividorLineView)
            make.trailing.equalTo(dividorLineView.snp.leading)
        }
        
        dailyHighTemperature.snp.makeConstraints { (make) in
            make.size.equalTo(80)
            make.centerY.equalTo(dividorLineView)
            make.leading.equalTo(dividorLineView.snp.trailing)
        }
    }
}
