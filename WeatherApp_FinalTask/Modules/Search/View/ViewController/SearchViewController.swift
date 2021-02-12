//
//  SearchViewController.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import UIKit
import SnapKit
import Combine
import NotificationCenter

class SearchViewController: UIViewController {
    //MARK: Properties
    weak var coordinator: SearchCoordinator?
    
    let textDidChangePublisher = PassthroughSubject<String, Never>()
    
    var viewModel: SearchViewModel
    
    var disposeBag = Set<AnyCancellable>()

    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
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
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: Init
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("search VC finished")
    }

}

//MARK: - Lifecycle
extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        tableView.backgroundColor = .clear
        setupView()
        setupBindings()
        configureTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.delegate = self
        activateSearch()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        coordinator?.searchDidFinish()
    }
}

private extension SearchViewController {
    func setupView() {
        let views = [blurEffectView, searchBar, tableView, dismissButton]
        view.addSubviews(views)
        setupLayout()
        setupButtonActions()
    }
    
    func setupLayout() {
        blurEffectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints { (make) in
            make.size.equalTo(25)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }
        searchBar.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalTo(view).inset(UIEdgeInsets(top: 0, left: 10, bottom: 100, right: 10))
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(searchBar.snp.top)
        }
    }
    
    func offsetSearchBar(for amount: CGFloat) {
        searchBar.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).inset(amount)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
         }
    
        offsetSearchBar(for: keyboardSize.height)
    }
    
    func activateSearch() {
        searchBar.becomeFirstResponder()
     }

    func setupBindings() {
        let dataLoader = viewModel.initializeScreenData(for: viewModel.loadData)
        dataLoader.store(in: &disposeBag)
        
        viewModel.screenDataReadyPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &disposeBag)
        
        textDidChangePublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] input in
                self?.viewModel.loadData.send(input)
            })
            .store(in: &disposeBag)
        
        let selectedCityUpdater = viewModel.attachSelectedCityUpdater(subject: viewModel.updateSelectedCityPublisher)
        selectedCityUpdater.store(in: &disposeBag)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: Actions
    func setupButtonActions() {
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    
    @objc func dismissButtonTapped() {
        presentingViewController?.dismiss(animated: false, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let input = searchBar.text else {
            return
        }
        viewModel.loadData.send(input)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let input = searchBar.text else {
            return
        }
        textDidChangePublisher.send(input)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.screenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityName = viewModel.screenData[indexPath.row]
    
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        cell.textLabel?.text = cityName
        
        cell.backgroundColor = .clear
               
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = viewModel.screenData[indexPath.row]
        viewModel.updateSelectedCityPublisher.send(selectedCity)
        if let presenter = coordinator?.presenter as? CurrentWeatherViewController {
            presenter.makeApiCall()
        }
        coordinator?.searchDidFinish()
    }
}
