//
//  RecordController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/03/30.
//

import UIKit

final class RecordViewController: UIViewController {
    
    // MARK: - Properties
    
    let cordDataManager = CoreDataManager.shared
    let themeDataManager = ThemeDataManager.shared
    let recordView = RecordView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordView.escapeHistoryTableView.dataSource = self
        recordView.escapeHistoryTableView.delegate = self
        recordView.escapeHistoryTableView.register(EscapeHistoryTableViewCell.self, forCellReuseIdentifier: EscapeHistoryTableViewCell.identifier)
        configureUI()
        configureNavi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recordView.escapeHistoryTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setting
    
    func configureUI() {
        
    }
    
    func configureNavi() {
        navigationController?.navigationBar.backgroundColor = .clear
        let image = UIImage(systemName: "square.and.pencil")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .customOrange
    }
    
    
    // MARK: - Action

    @objc func addButtonTapped() {
        let detailVC = RecordDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.title = "기록하기"
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

// MARK: - Extension

extension RecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = cordDataManager.getRecordThemesFromCoreData().count
        print("DEBUG: EscapeHistoryTableView - \(#function), DataCounter \(count)개")
        return cordDataManager.getRecordThemesFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EscapeHistoryTableViewCell.identifier, for: indexPath) as? EscapeHistoryTableViewCell else { return UITableViewCell() }
        let recordData = cordDataManager.getRecordThemesFromCoreData()
        cell.recordData = recordData[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "최근 탈출 기록"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .boldSystemFont(ofSize: 20)
        header.textLabel?.textColor = Setup.Color.textColor
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension RecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = RecordDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.navigationItem.largeTitleDisplayMode = .never
        detailVC.recordData = cordDataManager.getRecordThemesFromCoreData()[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


