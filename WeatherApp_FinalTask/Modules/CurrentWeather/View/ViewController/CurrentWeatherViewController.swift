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
        button.setImage(UIImage(named: "settings"), for: .normal)
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
    
    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData.send(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupView()
        setupBindings()
        setupButtonActions()
        viewModel.loadData.send(true)
    }
}
//MARK: - UI Setup
private extension CurrentWeatherViewController {
    func setupView() {
        view.addSubview(backgroundImageView)
        view.addSubview(settingsButton)
        view.addSubview(currentWeatherView)
        view.addSubview(searchBar)

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
            make.size.equalTo(50)
            make.leading.equalTo(view).inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide)        }
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(settingsButton.snp.trailing).inset(10)
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
    }
    
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
            }
            .store(in: &disposeBag)
    }
}

private extension CurrentWeatherViewController {
    private func showBlurView( _ shouldShowLoader: Bool) {
        if shouldShowLoader {
            showBlurView()
        } else {
            removeBlurView()
        }
    }
}
extension CurrentWeatherViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchRepository = GeoNamesRepositoryImpl()
        let vm = SearchViewModel(repository: searchRepository)
        let searchViewController = SearchViewController(viewModel: vm)
        searchViewController.modalPresentationStyle = .fullScreen
        self.present(searchViewController, animated: false, completion: nil)
    }
}
