//
//  SettingsViewController.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 17.01.2021..
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    //MARK: Properties
    weak var coordinator: SettingsCoordinator?
    
    var viewModel: SettingsViewModel

    let settingsView: SettingsView = {
        let view = SettingsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        navigationController?.navigationBar.isHidden = false
        setupView()
        setupBindings()
        settingsView.configure(with: viewModel.selectedCities)
    }
}

private extension SettingsViewController {
    func setupView() {
        view.addSubview(settingsView)
        setupConstraints()
    }
    
    func setupConstraints() {
        settingsView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.bottom.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setupBindings() {
        settingsView.locationsView.goToWeatherInformation = { [weak self] in
            self?.coordinator?.goToWeatherInformation()
        }
    }
}

