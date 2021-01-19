//
//  LocationsTableViewCell.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit
import SnapKit

class CityTableViewCell: UITableViewCell {
    //MARK: Properties
    var deleteCity: (() -> Void)?
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .systemRed
        return button
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Init
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI
private extension CityTableViewCell {
    func setupUI() {
        backgroundColor = UIColor(named: "settingsBackgroundColor")
        contentView.addSubviews([deleteButton, cityNameLabel])
        setupLayout()
        setupButtonActions()
    }
    
    func setupLayout() {
        deleteButton.snp.makeConstraints { (make) in
            make.size.equalTo(20)
            make.leading.bottom.equalTo(self).inset(10)
        }
        
        cityNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(deleteButton.snp.trailing).offset(5)
            make.top.bottom.trailing.equalTo(self)
        }
    }
    
    func setupButtonActions() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped() {
        deleteCity?()
    }
}

extension CityTableViewCell {
    func configure(with cityName: String) {
        cityNameLabel.text = cityName
    }
}
