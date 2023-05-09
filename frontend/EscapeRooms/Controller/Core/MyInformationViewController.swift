//
//  MyInformationViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/03/09.
//

import UIKit
import FirebaseAuth

final class MyInformationViewController: UIViewController {

    
    // MARK: - Properties
    
    // MARK: - Components
    
    var themes: [Theme] = []
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.setTitle("로그아웃", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureUI()
    }
    
    // MARK: - SettingUI
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(logoutButton)
    }
    
    func configureUI() {
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Action

    @objc func logoutButtonTapped() {
        print(#function)
        NetworkingManager.shared.fetchTheme { result in
            switch result {
            case Result.success(let themeData):
                self.themes = themeData
//                DispatchQueue.main.async {
//                    self.mainView.titleCollectionView.reloadData()
//                }
                print("MainVC에서 데이터를 전달 받음.")
            case Result.failure(let error):
                print(error.localizedDescription)
            }
        }
        print(themes.count)
//        print(#function)
//        do {
//            try Auth.auth().signOut()
//            let vc = LoginViewController()
//            vc.hidesBottomBarWhenPushed = true
//            vc.navigationItem.hidesBackButton = true
//            self.navigationController?.pushViewController(vc, animated: true)
//        } catch let error as NSError {
//            print("ERROR: \(error)")
//        }
    }

}
