//
//  UnitsSelectionView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit
import SnapKit
import DLRadioButton

class UnitsSelectionView: UIView {
    //MARK: Properties
    var cities: [String] = []
    
    let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Units"
        label.textAlignment = .center
        return label
    }()
    
    let metricSelectionButton: DLRadioButton = {
        let button = DLRadioButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Metric", for: [])
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.setTitleColor(.black, for: [])
        button.iconColor = .white
        button.indicatorColor = .white
        return button
    }()
    
    let imperialSelectionButton: DLRadioButton = {
        let button = DLRadioButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Imperial", for: [])
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.setTitleColor(.black, for: [])
        button.iconColor = .white
        button.indicatorColor = .white
        return button
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

//MARK: - UI
private extension UnitsSelectionView {
    func setupView() {
        let views = [sectionNameLabel, metricSelectionButton, imperialSelectionButton]
        addSubviews(views)
        setupConstraints()
        setupButtonActions()
    }
    
    func setupConstraints() {
        sectionNameLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self)
        }
        
        metricSelectionButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(sectionNameLabel.snp.bottom).offset(10)
        }
        
        imperialSelectionButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(metricSelectionButton.snp.bottom)
        }
    }
    
    func setupButtonActions() {
        metricSelectionButton.otherButtons = [imperialSelectionButton]
        let selectedUnit = Defaults.getSelectedUnits()
        switch selectedUnit {
        case Units.imperial.rawValue:
            imperialSelectionButton.isSelected = true
        default:
            metricSelectionButton.isSelected = true
        }
    }
}

extension UnitsSelectionView {
    func saveSelection() {
        if metricSelectionButton.isSelected {
            Defaults.saveUnits(Units.metric.rawValue)
        } else {
            Defaults.saveUnits(Units.imperial.rawValue)
            print(Defaults.getSelectedUnits())
        }
    }
}
