//
//  FavoritesViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/02/27.
//

import UIKit

final class LikesViewController: UIViewController {
    
    // MARK: - Propertis

    private var tableView = UITableView()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        configureTableView()
    }
    
    // MARK: - Setting
    
    func configureNaviBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 29/255, green: 45/255, blue: 68/255, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        // 네비게이션 타이틀("테마") 왼쪽으로 위치
//        appearance.titlePositionAdjustment = .init(horizontal: -CGFloat.greatestFiniteMagnitude, vertical: 0)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(LikesCell.self, forCellReuseIdentifier: "LikesCell")
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 29/255, green: 45/255, blue: 68/255, alpha: 1)
        tableView.rowHeight = 150
        
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
//        return likeThemes.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("DEBUG: Transfer Cell data")
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikesCell", for: indexPath) as! LikesCell
        
//        cell.image.image = likeThemes[indexPath.row].image
//        cell.nameLabel.text = likeThemes[indexPath.row].name
//        cell.companyLabel.text = likeThemes[indexPath.row].company
//        cell.difficultyLabel.text = likeThemes[indexPath.row].difficulty
//        cell.playTimeLabel.text = likeThemes[indexPath.row].playTime
//        cell.personnelLabel.text = likeThemes[indexPath.row].personnel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print("DEBUG: Section Spacing Setting")
        return 1
    }
}


extension LikesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ThemeDetailViewContoller()
//        detailVC.themes = likeThemes[indexPath.section]
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
