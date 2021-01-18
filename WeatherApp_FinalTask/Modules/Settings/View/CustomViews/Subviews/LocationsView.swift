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
    
    let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Locations"
        label.textAlignment = .center
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
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
        addSubview(sectionNameLabel)
        addSubview(tableView)
        setupConstraints()
        configureTableView()
    }
    
    func setupConstraints() {
        sectionNameLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(sectionNameLabel.snp.bottom)
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
        
        return cell
    }
}
