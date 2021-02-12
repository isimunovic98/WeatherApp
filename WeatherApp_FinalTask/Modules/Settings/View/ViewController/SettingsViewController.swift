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
    
    var backgroundImage: UIImage
    
    let settingsView: SettingsView = {
        let view = SettingsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Init
    init(viewModel: SettingsViewModel, backgroundImage: UIImage) {
        self.viewModel = viewModel
        self.backgroundImage = backgroundImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("settings VC finished")
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
            coordinator?.settingsDidFinish()
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
            make.edges.equalToSuperview()
        }
    }
    
    func reloadView() {
        settingsView.configure(with: viewModel.screenData)
    }
    
    func processDeleteTapped(on index: Int) {
        viewModel.deleteButtonTapped.send(index)
    }
    
    func setupAppearance() {
        settingsView.backgroundImageView.image = backgroundImage
    }

}

//MARK: Bindings
private extension SettingsViewController {
    func setupBindings() {
        settingsView.goToWeatherInformation = { [weak self] in
            self?.coordinator?.settingsDidFinish()
        }
        settingsView.locationsView.goToWeatherInformation = { [weak self] currentCity in
            self?.viewModel.updateCurrentCity(with: currentCity)
            self?.coordinator?.settingsDidFinish()
        }
        
        settingsView.locationsView.deleteCity = { [weak self] index in
            self?.processDeleteTapped(on: index)
        }
        
        settingsView.unitsView.saveSelectedUnit = { [weak self] value in
            self?.viewModel.saveSelectedUnitPublisher.send(value)
        }
        
        settingsView.conditionsView.saveSelecteConditions = { [weak self] value in
            self?.viewModel.saveSelectedConditionsPublisher.send(value)
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
        
        let saveSelectedUnit = viewModel.saveSelectedUnit(subject: viewModel.saveSelectedUnitPublisher)
        saveSelectedUnit.store(in: &disposeBag)
        
        let saveSelectedConditions = viewModel.saveSelectedConditions(subject: viewModel.saveSelectedConditionsPublisher)
        saveSelectedConditions.store(in: &disposeBag)
    }
    
}
