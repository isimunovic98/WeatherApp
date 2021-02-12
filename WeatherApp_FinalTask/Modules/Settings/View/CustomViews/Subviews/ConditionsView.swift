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
    var saveSelecteConditions: ((Conditions) -> Void)?
    
    let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Conditions"
        label.font = label.font.withSize(25)
        label.textColor = .white
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
        addSubviews([sectionNameLabel, stackView])
        
        let views = [windSpeedConditionView, pressureConditionView, humidityConditionView]
        stackView.addArrangedSubviews(views)
        
        setupLayout()
        configureButtons()
    }
    
    func setupLayout() {
        sectionNameLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
        }
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(sectionNameLabel.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalTo(self)
        }
    }
    func configureButtons() {
        let firstButton = windSpeedConditionView.conditionSelectionButton
        firstButton.otherButtons = [pressureConditionView.conditionSelectionButton, humidityConditionView.conditionSelectionButton]
        firstButton.isMultipleSelectionEnabled = true
    }
}

extension ConditionsView {
    func configure(with conditions: Conditions) {
        windSpeedConditionView.conditionSelectionButton.isSelected = conditions.windSpeedIsSelected
        pressureConditionView.conditionSelectionButton.isSelected = conditions.pressureIsSelected
        humidityConditionView.conditionSelectionButton.isSelected = conditions.humidityIsSelected
    }
    
    func saveSelection() {
        let windSpeedIsSelected = windSpeedConditionView.conditionSelectionButton.isSelected
        let pressureIsSelected = pressureConditionView.conditionSelectionButton.isSelected
        let humidityIsSelected = humidityConditionView.conditionSelectionButton.isSelected
        let selectedConditions = Conditions(pressureIsSelected: pressureIsSelected, windSpeedIsSelected: windSpeedIsSelected, humidityIsSelected: humidityIsSelected)
        saveSelecteConditions?(selectedConditions)
    }
}
