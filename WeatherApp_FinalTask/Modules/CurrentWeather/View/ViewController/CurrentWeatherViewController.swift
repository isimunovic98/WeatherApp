//
//  CurrentWeatherViewController.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import UIKit
import SnapKit

class CurrentWeatherViewController: UIViewController {
    
    //MARK: Properties
    let currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupView()
    }
}

//MARK: - UI Setup
private extension CurrentWeatherViewController {
    func setupView() {
        view.addSubview(currentWeatherView)
        view.addSubview(searchBar)
        
        setupAppearance()
        setupLayout()
    }
    
    func setupAppearance() {
        view.backgroundColor = .gray
    }
    
    func setupLayout() {
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
        }
        
        currentWeatherView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.bottom.trailing.equalTo(view)
        }
    }
}

extension CurrentWeatherViewController {
}

extension CurrentWeatherViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchViewController = SearchViewController()
        self.present(searchViewController, animated: false, completion: nil)
    }
}
