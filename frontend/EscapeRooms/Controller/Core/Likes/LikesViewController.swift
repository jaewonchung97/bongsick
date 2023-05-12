//
//  FavoritesViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/02/27.
//

import UIKit

final class LikesViewController: UIViewController {
    
    // MARK: - Propertis
    private let themeDataManager = ThemeDataManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    private var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = Setup.Color.backgroundColor
        tv.rowHeight = 150
        return tv
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Setting
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(LikesCell.self, forCellReuseIdentifier: "LikesCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }

    // MARK: - Action


    
    
}

// MARK: - Extension

extension LikesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themeDataManager.getLikedThemeArraysFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("DEBUG: Transfer Cell data")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikesCell", for: indexPath) as? LikesCell else { return UITableViewCell() }
        let theme = themeDataManager.getLikedThemeArraysFromCoreData()[indexPath.row]
        cell.delegate = self
        cell.theme = theme
        return cell
    }
}


extension LikesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ThemeDetailViewContoller()
        let theme = themeDataManager.getLikedThemeArraysFromCoreData()[indexPath.row]
        detailVC.likedTheme = theme
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension LikesViewController: LikesCellDelegate {
    func likeButtonTapped(cell: LikesCell, likeState: Bool) {
        print("DEBUG: Canceled Liked Theme")
        cell.theme?.isLiked = false
        guard let theme = cell.theme else { return }
        themeDataManager.cancelLikedThemeFromCoreData(with: theme) {
            self.tableView.reloadData()
        }
    }
}
