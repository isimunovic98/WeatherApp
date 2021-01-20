//
//  SettingsView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit

class SettingsView: UIView {
    //MARK: Properties
    let locationsView: LocationsView = {
        let view = LocationsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let unitsView: UnitsSelectionView = {
        let view = UnitsSelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let conditionsView: ConditionsView = {
        let view = ConditionsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = .darkGray
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

private extension SettingsView {
    func setupView() {
        let views = [locationsView, unitsView, conditionsView, applyButton]
        addSubviews(views)
        setupLayout()
        setupApplyButton()
    }
    
    func setupLayout() {
        locationsView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(300)
        }
        
        unitsView.snp.makeConstraints { (make) in
            make.top.equalTo(locationsView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self).inset(15)
            make.height.equalTo(100)
        }
        
        conditionsView.snp.makeConstraints { (make) in
            make.top.equalTo(unitsView.snp.bottom)
            make.leading.trailing.equalTo(self)
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.top.equalTo(conditionsView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self).inset(100)
            make.height.equalTo(40)
        }
    }
    
    //MARK: Actions
    func setupApplyButton() {
        applyButton.addTarget(self, action: #selector(applyButtonPressed), for: .touchUpInside)
    }
    
    @objc func applyButtonPressed() {
        unitsView.saveSelection()
        conditionsView.saveSelection()
    }
}

extension SettingsView {
    func configure(with cities: [String]) {
        locationsView.configure(with: cities)
    }
}
