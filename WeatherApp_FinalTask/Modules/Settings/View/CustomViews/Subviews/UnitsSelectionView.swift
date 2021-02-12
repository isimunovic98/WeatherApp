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
    var saveSelectedUnit: ((Units) -> Void)?
    
    let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Units"
        label.font = label.font.withSize(25)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let metricSelectionButton: DLRadioButton = {
        let button = DLRadioButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Metric", for: [])
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.setTitleColor(.white, for: [])
        button.iconColor = .white
        button.indicatorColor = .white
        return button
    }()
    
    let imperialSelectionButton: DLRadioButton = {
        let button = DLRadioButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Imperial", for: [])
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.setTitleColor(.white, for: [])
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
        setupLayout()
        setupButtons()
    }
    
    func setupLayout() {
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
    
    func setupButtons() {
        metricSelectionButton.otherButtons = [imperialSelectionButton]
    }
}

extension UnitsSelectionView {
    func configure(with unit: String) {
        if unit == Units.imperial.rawValue {
            imperialSelectionButton.isSelected = true
        } else {
            metricSelectionButton.isSelected = true
        }
    }
    func saveSelection() {
        if metricSelectionButton.isSelected {
            saveSelectedUnit?(Units.metric)
        } else {
            saveSelectedUnit?(Units.imperial)
        }
    }
}
