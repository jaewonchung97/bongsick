//
//  MainViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/26.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let sectionTitles: [String] = ["코미디", "SF/판타지", "공포/스릴러", "모험", "추리"]
    
    let mainView = MainView()
    
    // MARK: - Life Cycle

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.titleCollectionView.dataSource = self
        mainView.titleCollectionView.delegate = self
        navigationController?.navigationBar.tintColor = .white
//        let image = UIImage(named: "exit.png")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
//        navigationItem.leftBarButtonItem?.tintColor = .customOrange
    }
    
    // MARK: - Setting

}

// MARK: - Extention

// MARK: - UITableView

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThemeTableViewCell.identifier, for: indexPath) as? ThemeTableViewCell else { return UITableViewCell() }
        cell.themeData = ThemeDataManager.shared.getThemeData()
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .boldSystemFont(ofSize: 20)
        header.textLabel?.textColor = .white
    }
}

// MARK: - UICollectionView

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let titleData = ThemeDataManager.shared.getThemeData()
        return titleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestThemeViewCell.identifier, for: indexPath) as? BestThemeViewCell else { return UICollectionViewCell() }
        let data = ThemeDataManager.shared.getThemeData()
        cell.imageView.image = data[indexPath.row].image
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

// MARK: - ThemeTableViewCellDelegate

extension MainViewController: ThemeTableViewCellDelegate {
    func moveDetailView(indexPath: IndexPath) {
        let vc = ThemeDetailViewContoller()
        vc.hidesBottomBarWhenPushed = true
        vc.navigationItem.largeTitleDisplayMode = .never
        let themeData = ThemeDataManager.shared.getThemeData()
        vc.themeData = themeData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        print(#function)
    }
}
