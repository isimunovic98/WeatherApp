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
    var disposeBag = Set<AnyCancellable>()
    
    private var viewModel: CurrentWeatherViewModel
    
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
    
    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupView()
        setupBindings()
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
         view.backgroundColor = .white
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
    
    func reloadView() {
        guard let screenData = viewModel.screenData else { return }
        currentWeatherView.configure(with: screenData)
    }
}
//MARK: - Bindings
extension CurrentWeatherViewController {
    func setupBindings() {
        let dataLoader = viewModel.initializeScreenData(for: viewModel.loadData)
        dataLoader.store(in: &disposeBag)
        
        viewModel.screenDataReady
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
        let searchViewController = SearchViewController()
        self.present(searchViewController, animated: false, completion: nil)
    }
}
