//
//  SettingsViewController.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 17.01.2021..
//

import UIKit
import SnapKit
import Combine

class SettingsViewController: UIViewController {
    //MARK: Properties
    weak var coordinator: SettingsCoordinator?
    
    var viewModel: SettingsViewModel

    var disposeBag = Set<AnyCancellable>()
    
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
        setupAppearance()
        setupView()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData.send(nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            navigationController?.navigationBar.isHidden = true
        }
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
    
    func reloadView() {
        settingsView.configure(with: viewModel.screenData)
    }
    
    func processDeleteTapped(on index: Int) {
        viewModel.deleteButtonTapped.send(index)
    }
    
    func setupAppearance() {
        view.backgroundColor = UIColor(named: "settingsBackgroundColor")
    }

}

//MARK: Bindings
private extension SettingsViewController {
    func setupBindings() {
        settingsView.locationsView.goToWeatherInformation = { [weak self] in
            self?.coordinator?.goToWeatherInformation()
        }
        
        settingsView.locationsView.deleteCity = { [weak self] index in
            self?.processDeleteTapped(on: index)
        }
        
        let loadData = viewModel.initializeScreenData(for: viewModel.loadData)
        loadData.store(in: &disposeBag)
        
        viewModel.screenDataReadyPublisher
            .subscribe(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.reloadView()
            })
            .store(in: &disposeBag)
        
        let deleteListener = viewModel.attachDeleteButtonClickListener(listener: viewModel.deleteButtonTapped)
        deleteListener.store(in: &disposeBag)
    }
    
    
}
