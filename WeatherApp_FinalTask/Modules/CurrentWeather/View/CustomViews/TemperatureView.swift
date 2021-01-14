//
//  TemperatureView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import UIKit
import SnapKit

enum TemperatureUnit: String {
    case metric = "°C"
    case imperial = "°F"
}

class TemperatureView: UIView {

    //MARK: Properties
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let temperatureUnitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TemperatureUnit.metric.rawValue
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }

}

// - MARK: UI Setup
private extension TemperatureView {
    func setupView() {
        addSubview(stackView)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(temperatureUnitLabel)
        setupLayout()

    }
    
    func setupLayout() {
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(10)
        }
    }
}

//MARK: - Configuration
extension TemperatureView {

}
