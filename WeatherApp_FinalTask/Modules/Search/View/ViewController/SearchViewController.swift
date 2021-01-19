//
//  SearchViewController.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import UIKit
import SnapKit
import Combine

class SearchViewController: UIViewController {
    //MARK: Properties
    var viewModel: SearchViewModel
    
    var disposeBag = Set<AnyCancellable>()
    
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
        button.backgroundColor = .red
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupView()
        setupBindings()
        configureTableView()
    }
}

private extension SearchViewController {
    func setupView() {
        let views = [searchBar, tableView, dismissButton]
        view.addSubviews(views)
        searchBar.delegate = self
        setupConstraints()
        activateSearch()
    }
    
    func setupConstraints() {
        dismissButton.snp.makeConstraints { (make) in
            make.size.equalTo(45)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(20)
        }
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(dismissButton.snp.leading).inset(20)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(5)
        }
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
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let input = searchBar.text else {
            return
        }
        searchBar.endEditing(true)
        viewModel.loadData.send(input)
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
               
        return cell
    }
}
