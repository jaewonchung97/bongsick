//
//  ThemeViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/02/23.
//

import UIKit
import FirebaseAuth

final class ThemeViewController: UIViewController {
    
    // MARK: - Properties
    
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredThemeData: [Theme] = []

    var likeThemes: [Theme] = []
    
    let themeDataManager = ThemeDataManager.shared
    
    let likeButtonConfigure = UIImage.SymbolConfiguration(pointSize: 25)
    
    var isFiltering: Bool {
            let searchController = self.navigationItem.searchController
            let isActive = searchController?.isActive ?? false
            let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
            return isActive && isSearchBarHasText
    }
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNaviBar()
        configureSearchBar()
        configureTableView()
//        checkIfUserIsLoggedIn()
    }
    
    // MARK: - Setting
    
    func configureNaviBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.navy
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        // 네비게이션 타이틀("테마") 왼쪽으로 위치
//        appearance.titlePositionAdjustment = .init(horizontal: -CGFloat.greatestFiniteMagnitude, vertical: 0)
        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .black
        searchController.searchBar.placeholder = "테마를 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = true
        //obobscuresBackgroundDuringPresentation
        
        if let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchField.backgroundColor = UIColor.white
            searchField.textColor = UIColor.black
        }
        
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
//        searchBar.setImage(UIImage(named: "icSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
//        searchBar.placeholder = "테마를 입력해주세요."
//        self.navigationController?.navigationBar.topItem?.titleView = searchBar
//
//        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
//            //서치바 백그라운드 컬러
//            textfield.backgroundColor = UIColor.white
//            //플레이스홀더 글씨 색 정하기
//            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
//            //서치바 텍스트입력시 색 정하기
//            textfield.textColor = UIColor.black
//            //왼쪽 아이콘 이미지넣기
//            if let leftView = textfield.leftView as? UIImageView {
//                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
//                //이미지 틴트컬러 정하기
//                leftView.tintColor = UIColor.lightGray
//            }
//        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.register(ThemeCell.self, forCellReuseIdentifier: "ThemeCell")
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 150
        tableView.backgroundColor = UIColor(red: 29/255, green: 45/255, blue: 68/255, alpha: 1)
        
        NSLayoutConstraint.activate([
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    
    // MARK: - Action
    
//    func getThemeData() {
//        themesManager.makeThemeData()
//        themes = themesManager.getThemeData()
//    }
    
    // 사용자가 연결되었는지 확인
//    func checkIfUserIsLoggedIn() {
//        if Auth.auth().currentUser == nil {
//            let vc = LoginViewController()
//            vc.hidesBottomBarWhenPushed = true
//            vc.navigationItem.hidesBackButton = true
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }


}

// MARK: - 확장

extension ThemeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let themeData = themeDataManager.getThemeData()
        return self.isFiltering ? self.filteredThemeData.count : themeData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("DEBUG: Transfer Cell data")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath)
//        cell.delegate = self
        return cell
        
//        if self.isFiltering {
//            cell.image.image = filteredThemeData[indexPath.section].image
//            cell.nameLabel.text = filteredThemeData[indexPath.section].name
//            cell.companyLabel.text = filteredThemeData[indexPath.section].company
//            cell.difficultyLabel.text = filteredThemeData[indexPath.section].difficulty
//            cell.playTimeLabel.text = filteredThemeData[indexPath.section].playTime
//            cell.personnelLabel.text = filteredThemeData[indexPath.section].personnel
//            let themeData = themeDataManager.getThemeData()
//            cell.theme = themeData[indexPath.section]
//            return cell
//
//        } else {
//            let themeData = themeDataManager.getThemeData()
//            cell.image.image = themeData[indexPath.section].image
//            cell.nameLabel.text = themeData[indexPath.section].name
//            cell.companyLabel.text = themeData[indexPath.section].company
//            cell.difficultyLabel.text = themeData[indexPath.section].difficulty
//            cell.playTimeLabel.text = themeData[indexPath.section].playTime
//            cell.personnelLabel.text = themeData[indexPath.section].personnel
//            cell.theme = themeData[indexPath.section]
//            return cell
//        }
        
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

extension ThemeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ThemeDetailViewContoller()
        let themeData = themeDataManager.getThemeData()
        detailVC.themeData = themeData[indexPath.section]
        // ThemeDetailView 로 넘어가면서 탭바를 숨긴다.
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

//extension ThemeViewController: ThemeCellDelegate {
//
//    func addLikeTheme(_ cell: ThemeCell, add theme: Theme) {
//        print("DEBUG: 좋아요 버튼이 눌린 셀의 정보를 전달합니다.")
//        cell.likeButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: likeButtonConfigure), for: .normal)
//        cell.likeButton.tintColor = .orange
//        themesManager.likeThemes.append(theme)
//        print(themesManager.likeThemes.count)
//    }
//
//    func removeLikeTheme(_ cell: ThemeCell, remove theme: Theme) {
//        cell.likeButton.setImage(UIImage(systemName: "heart", withConfiguration: likeButtonConfigure), for: .normal)
//        cell.likeButton.tintColor = .lightGray
//    }
//}

extension ThemeViewController: UISearchBarDelegate {
    
}

extension ThemeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    func filteredContentForSearchText(_ text: String) {
        let themeData = themeDataManager.getThemeData()
        filteredThemeData = themeData.filter({ (themeData) -> Bool in
            return themeData.name.lowercased().contains(text.lowercased()) || themeData.name.lowercased().contains(text.lowercased())
        })
        
        tableView.reloadData()
    }
    
    
}
