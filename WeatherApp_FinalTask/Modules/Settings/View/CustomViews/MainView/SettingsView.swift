//
//  SettingsView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit

class SettingsView: UIView {
    //MARK: Properties
    var goToWeatherInformation: (() -> Void)?
    
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        backgroundImageView.addSubview(blurEffectView)
        let views = [backgroundImageView, locationsView, unitsView, conditionsView, applyButton]
        addSubviews(views)
        setupLayout()
        setupApplyButton()
    }
    
    func setupLayout() {
        blurEffectView.snp.makeConstraints { (make) in
            make.edges.equalTo(backgroundImageView)
        }
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).inset(20)
            make.centerX.equalTo(self)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        unitsView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.height.equalTo(100)
            make.leading.trailing.equalTo(self).inset(20)
        }
        
        conditionsView.snp.makeConstraints { (make) in
            make.top.equalTo(unitsView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
        }
        
        locationsView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(unitsView.snp.top)
            make.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    //MARK: Actions
    func setupApplyButton() {
        applyButton.addTarget(self, action: #selector(applyButtonPressed), for: .touchUpInside)
    }
    
    @objc func applyButtonPressed() {
        unitsView.saveSelection()
        conditionsView.saveSelection()
        goToWeatherInformation?()
    }
}

extension SettingsView {
    func configure(with model: SettingsModel) {
        locationsView.configure(with: model.savedCities)
        unitsView.configure(with: model.selectedUnit)
        conditionsView.configure(with: model.selectedConditions)
    }
}
