//
//  SearchViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/08.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Property
    
    private let themeDataManager = ThemeDataManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupSearchController()
        configureTableView()
        setConstraints()
        setupThemeData()
        print("DEBUG: SearchView Did Load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupThemeData()
        print("DEBUG: SearchView Will Appear")
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
        themeDataManager.setupDataFromAPI {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArray.count
        } else {
            return themeDataManager.getThemeArraysFromAPI().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewTableViewCell.identifier, for: indexPath) as? SearchViewTableViewCell else { return UITableViewCell() }
        
        let theme = themeDataManager.getThemeArraysFromAPI()[indexPath.row]
        if isFiltering {
            cell.theme = filteredArray[indexPath.row]
        } else {
            cell.theme = theme
            cell.setupButton()
        }
        cell.delegate = self
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.mainImageView.contentMode = .scaleAspectFill
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableView.Length.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ThemeDetailViewContoller()
        let theme = themeDataManager.getThemeArraysFromAPI()[indexPath.row]
        detailVC.theme = theme
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
        filteredArray = themeDataManager.getThemeArraysFromAPI().filter { (theme: Theme) -> Bool in
            return theme.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

extension SearchViewController: SearchViewTableViewCellDelegate {
    func likeButtonTapped(cell: SearchViewTableViewCell, isLiked: Bool) {
        if isLiked == false {
            guard let theme = cell.theme else { return }
            themeDataManager.saveLikedTheme(with: theme) {
                theme.isLiked = true
                cell.setupButton()
                print("Add Liked Theme:", theme.name)
            }
        } else {
            guard let theme = cell.theme else { return }
            themeDataManager.cancelLikedTheme(with: theme) {
                theme.isLiked = false
                cell.setupButton()
                print("Canceld Like Theme:", theme.name)
            }
        }
    }
}
