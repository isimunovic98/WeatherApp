//
//  CurrentWeatherViewController.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import UIKit
import SnapKit
import Combine

class CurrentWeatherViewController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: CurrentWeatherCoordinator?
    
    var disposeBag = Set<AnyCancellable>()
    
    private var viewModel: CurrentWeatherViewModel
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .medium)
        button.setImage(UIImage(systemName: "gearshape", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "search"
        searchBar.isTranslucent = true
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .gray
        return searchBar
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
        searchBar.delegate = self
        setupView()
        setupBindings()
        setupButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData.send(true)
    }
}

//MARK: - UI Setup
private extension CurrentWeatherViewController {
    func setupView() {
        let views = [backgroundImageView, settingsButton, currentWeatherView, searchBar]
        view.addSubviews(views)
        setupAppearance()
        setupLayout()
     }

     func setupAppearance() {
        backgroundImageView.image = UIImage(named: "body_image-clear-day.png")
     }

     func setupLayout() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        settingsButton.snp.makeConstraints { (make) in
            make.size.equalTo(35)
            make.leading.equalTo(view).inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide)        }
        
        searchBar.snp.makeConstraints { (make) in
            make.centerY.equalTo(settingsButton)
            make.leading.equalTo(settingsButton.snp.trailing).offset(10)
            make.trailing.equalTo(view).inset(10)
        }
        
        currentWeatherView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.bottom.trailing.equalTo(view)
        }

    }
    
    func reloadView() {
        guard let screenData = viewModel.screenData else { return }
        currentWeatherView.configure(with: screenData)
        configureBackgroundImage(for: screenData.weatherId,and: screenData.icon)
    }
    
    func showBlurView( _ shouldShowLoader: Bool) {
        if shouldShowLoader {
            showBlurView()
        } else {
            removeBlurView()
        }
    }
    
    func configureBackgroundImage(for id: Int, and dayNightIndicator: String) {
        let backgroundImage = BackgroundImageManager.getBackgroundImage(for: id, and: dayNightIndicator)
        backgroundImageView.image = backgroundImage
    }
    
    //MARK: Actions
    func setupButtonActions() {
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
    }
    
    @objc func settingsButtonPressed() {
        coordinator?.goToSettings()
    }
}

//MARK: - Bindings
extension CurrentWeatherViewController {
    func setupBindings() {
        let dataLoader = viewModel.initializeScreenData(for: viewModel.loadData)
        dataLoader.store(in: &disposeBag)
        
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
