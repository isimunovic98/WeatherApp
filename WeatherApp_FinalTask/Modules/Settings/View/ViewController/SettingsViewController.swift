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
    
    //MARK: Init
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Lifecycle
extension SettingsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        setupView()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingsView.configure(with: viewModel.selectedCities)
    }
}

//MARK: - UI Setup
private extension SettingsViewController {
    func setupView() {
        view.addSubview(settingsView)
        setupLayout()
    }
    
    func setupLayout() {
        settingsView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.bottom.trailing.equalToSuperview().inset(10)
        }
    }
}

//MARK: Bindings
private extension SettingsViewController {
    func setupBindings() {
        settingsView.locationsView.goToWeatherInformation = { [weak self] in
            self?.coordinator?.goToWeatherInformation()
        }
    }
}
