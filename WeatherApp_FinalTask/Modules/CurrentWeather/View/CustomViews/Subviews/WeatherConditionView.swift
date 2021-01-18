//
//  WeatherConditionsView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 14.01.2021..
//

import UIKit
import SnapKit

class WeatherConditionView: UIView {

    //MARK: Properties
    
    let conditionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let conditionValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .vertical
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
private extension WeatherConditionView {
    func setupView() {
        addSubview(stackView)
        stackView.addArrangedSubview(conditionImage)
        stackView.addArrangedSubview(conditionValueLabel)
        setupLayout()

    }
    
    func setupLayout() {
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(10)
            make.width.equalTo(75)
            make.height.equalTo(100)
        }
    }
}

//MARK: - Configuration
extension WeatherConditionView {

}
