//
//  CurrentWeatherViewController.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import UIKit
import SnapKit
import Combine
import MapKit

class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: Properties
    weak var coordinator: CurrentWeatherCoordinator?
    
    var disposeBag = Set<AnyCancellable>()
    
    private var viewModel: CurrentWeatherViewModel
    
    let manager = CLLocationManager()
    
    let currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Init
    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Lifecycle
extension CurrentWeatherViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeatherView.searchBar.delegate = self
        configureLocationManager()
        setupView()
        setupBindings()
        setupButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData.send(true)
    }
}

extension CurrentWeatherViewController {
    func makeApiCall() {
        viewModel.loadData.send(false)
    }
}

//MARK: - UI Setup
private extension CurrentWeatherViewController {
    func setupView() {
        view.addSubview(currentWeatherView)
        setupLayout()
     }
    
    func configureLocationManager() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

     func setupLayout() {
        currentWeatherView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func showBlurView( _ shouldShowLoader: Bool) {
        if shouldShowLoader {
            showBlurView()
        } else {
            removeBlurView()
        }
    }
    
    func reloadView() {
        guard let screenData = viewModel.screenData else { return }
        currentWeatherView.configure(with: screenData)
        configureBackgroundImage(for: screenData.weatherId, and: screenData.dayNightIndicator)
    }
    
    func configureBackgroundImage(for id: Int, and dayNightIndicator: String) {
        let backgroundImage = BackgroundImageManager.getBackgroundImage(for: id, and: dayNightIndicator)
        currentWeatherView.backgroundImageView.image = backgroundImage
    }
    
    //MARK: Actions
    func setupButtonActions() {
        currentWeatherView.settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
    }

    @objc func settingsButtonPressed() {
        let backgroundImage = view.takeScreenshot()
        coordinator?.goToSettings(with: backgroundImage)
    }
}

//MARK: - Bindings
extension CurrentWeatherViewController {
    func setupBindings() {
        let dataLoader = viewModel.initializeScreenData(for: viewModel.loadData)
        dataLoader.store(in: &disposeBag)
        
        let locationListener = viewModel.attachLocationListener(subject: viewModel.useLocationPublisher)
        locationListener.store(in: &disposeBag)
        
        viewModel.screenDataReadyPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.reloadView()
            })
            .store(in: &disposeBag)
        
        viewModel.shouldShowBlurView
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] shouldShowBlurView in
                self?.showBlurView(shouldShowBlurView)
            })
            .store(in: &disposeBag)
        
        viewModel.errorPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink{ [weak self] errorMessage in
                guard let message = errorMessage else { return }
                self?.presentAlert(with: message)
                self?.showBlurView(false)
            }
            .store(in: &disposeBag)
    }
}

//MARK: - Seach Bar Delegate
extension CurrentWeatherViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        coordinator?.presentSearchScreen(on: self)
    }
}

//MARK: - Location Manager Delegate
extension CurrentWeatherViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            let coordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            viewModel.useLocationPublisher.send(coordinates)
        }

        
    }
}
