//
//  SettingsView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit

class SettingsView: UIView {
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
        let views = [locationsView, unitsView]
        addSubviews(views)
        setupConstraints()
    }
    
    func setupConstraints() {
        locationsView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(300)
        }
        
        unitsView.snp.makeConstraints { (make) in
            make.top.equalTo(locationsView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(400)
        }
        
    }
}

extension SettingsView {
    func configure(with cities: [String]) {
        locationsView.configure(with: cities)
    }
}
