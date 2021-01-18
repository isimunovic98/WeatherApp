//
//  ConditionsView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit
import SnapKit

class ConditionsView: UIView {
    
    //MARK: Properties
    let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Conditions"
        label.textAlignment = .center
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let windSpeedConditionView: ConditionSelectionView = {
        let view = ConditionSelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.conditionImageView.image = UIImage(named: Constants.ConditionImages.windIcon.rawValue)
        return view
    }()

    let pressureConditionView: ConditionSelectionView = {
        let view = ConditionSelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.conditionImageView.image = UIImage(named: Constants.ConditionImages.pressureIcon.rawValue)
        return view
    }()
    
    let humidityConditionView: ConditionSelectionView = {
        let view = ConditionSelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.conditionImageView.image = UIImage(named: Constants.ConditionImages.humidityIcon.rawValue)
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


private extension ConditionsView {
    func setupView() {
        addSubview(sectionNameLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(windSpeedConditionView)
        stackView.addArrangedSubview(pressureConditionView)
        stackView.addArrangedSubview(humidityConditionView)
        setupConstraints()
        setupButtons()
        configureButtons()
    }
    
    func setupConstraints() {
        sectionNameLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
        }
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(sectionNameLabel.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalTo(self)
        }
    }
    func setupButtons() {
        windSpeedConditionView.conditionSelectionButton.isSelected = !Defaults.windSpeedIsHidden()
        pressureConditionView.conditionSelectionButton.isSelected = !Defaults.pressureIsHidden()
        humidityConditionView.conditionSelectionButton.isSelected = !Defaults.humidityIsHidden()
    }
    func configureButtons() {
        let firstButton = windSpeedConditionView.conditionSelectionButton
        firstButton.otherButtons = [pressureConditionView.conditionSelectionButton, humidityConditionView.conditionSelectionButton]
        firstButton.isMultipleSelectionEnabled = true
    }
}

extension ConditionsView {
    func saveSelection() {
        Defaults.saveWindSpeedSelected(windSpeedConditionView.conditionSelectionButton.isSelected)
        Defaults.savePressureSelected(pressureConditionView.conditionSelectionButton.isSelected)
        Defaults.saveHumiditySelected(humidityConditionView.conditionSelectionButton.isSelected)
    }
}
