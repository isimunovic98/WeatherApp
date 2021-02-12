//
//  WeatherConditionsStackView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 14.01.2021..
//

import UIKit

class WeatherConditionsStackView: UIView {

    //MARK: Properties
    let windSpeedConditionView: WeatherConditionView = {
        let view = WeatherConditionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.conditionImageView.image = UIImage(named: Constants.ConditionImages.windIcon.rawValue)
        return view
    }()
    
    let pressureConditionView: WeatherConditionView = {
        let view = WeatherConditionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.conditionImageView.image = UIImage(named: Constants.ConditionImages.pressureIcon.rawValue)
        return view
    }()
    
    let humidityConditionView: WeatherConditionView = {
        let view = WeatherConditionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.conditionImageView.image = UIImage(named: Constants.ConditionImages.humidityIcon.rawValue)
        return view
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 35
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
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

// - MARK: UI Setup
private extension WeatherConditionsStackView {
    func setupView() {
        addSubview(stackView)
        let views = [windSpeedConditionView, pressureConditionView, humidityConditionView]
        stackView.addArrangedSubviews(views)
        setupLayout()

    }
    
    func setupLayout() {
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension WeatherConditionsStackView {
    func configure(with weatherInformation: WeatherInformation) {
        var windSpeedDisplay = Constants.windSpeedMetricDisplay(of: weatherInformation.windSpeed)
        if weatherInformation.selectedUnits == Units.imperial.rawValue {
            windSpeedDisplay = Constants.windSpeedImperialDisplay(of: weatherInformation.windSpeed)
        }
        humidityConditionView.conditionValueLabel.text = Constants.humidityDisplay(of: weatherInformation.humidity)
        pressureConditionView.conditionValueLabel.text = Constants.pressureDisplay(of: weatherInformation.pressure)
        windSpeedConditionView.conditionValueLabel.text = windSpeedDisplay
    }
}
