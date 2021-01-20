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
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
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
        stackView.distribution = .fillProportionally
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
private extension TemperatureView {
    func setupView() {
        addSubview(stackView)
        let views = [temperatureLabel, temperatureUnitLabel]
        stackView.addArrangedSubviews(views)
        setupLayout()

    }
    
    func setupLayout() {
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(10)
        }
    }
}
