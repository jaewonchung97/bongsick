//
//  SearchViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/08.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Property
    
    private let networkManager = NetworkingManager.shared
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var themeArray: [Theme] = []
    var filteredArray: [Theme] = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupSearchController()
        configureTableView()
        setConstraints()
        setupThemeData()
    }
    
    func addSubViews() {
        view.addSubview(tableView)
    }
    
    func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "테마를 입력해주세요."
        searchController.searchResultsUpdater = self
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchViewTableViewCell.self, forCellReuseIdentifier: SearchViewTableViewCell.identifier)
    }
    
    func setConstraints() {
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    func setupThemeData() {
        networkManager.fetchTheme { result in
            switch result {
            case Result.success(let themeData):
                self.themeArray = themeData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case Result.failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArray.count
        } else {
            return themeArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewTableViewCell.identifier, for: indexPath) as? SearchViewTableViewCell else { return UITableViewCell() }
        
        if isFiltering {
            cell.theme = filteredArray[indexPath.row]
        } else {
            cell.theme = themeArray[indexPath.row]
        }
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableView.Length.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ThemeDetailViewContoller()
        detailVC.theme = themeArray[indexPath.row]
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredArray = themeArray.filter { (theme: Theme) -> Bool in
            return theme.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
