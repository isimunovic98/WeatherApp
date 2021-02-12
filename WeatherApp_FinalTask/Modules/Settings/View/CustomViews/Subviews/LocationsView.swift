//
//  LocationsTableViewCell.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit
import SnapKit

class LocationsView: UIView {
    //MARK: Properties
    var cities: [String] = []
    
    var deleteCity: ((Int) -> Void)?
    
    var goToWeatherInformation: ((String) -> Void)?
    
    let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Locations"
        label.font = label.font.withSize(25)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
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
private extension LocationsView {
    func setupView() {
        let views = [sectionNameLabel, tableView]
        addSubviews(views)
        setupLayout()
        configureTableView()
    }
    
    func setupLayout() {
        sectionNameLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(sectionNameLabel.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalTo(self)
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44.0
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
    }
}

extension LocationsView {
    func configure(with cities: [String]) {
        self.cities = cities
        tableView.reloadData()
    }
}

extension LocationsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityName = cities[indexPath.row]
        
        let cell: CityTableViewCell = tableView.dequeue(for: indexPath)

        cell.configure(with: cityName)
        
        cell.deleteCity = { [weak self] in
            self?.deleteCity?(indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = cities[indexPath.row]
        goToWeatherInformation?(selectedCity)
    }
}
