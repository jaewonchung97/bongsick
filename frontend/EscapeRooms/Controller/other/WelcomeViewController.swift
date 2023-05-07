//
//  WelcomeViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/26.
//

import UIKit

final class WelcomeViewController: UIViewController {

    // MARK: - Properties
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "당신은 누구입니까?"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let nicknameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .orange
        tf.placeholder = "닉네임을 입력해주세요."
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("시작하기", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nicknameLabel, nicknameTextField, saveButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    // MARK: - Setting
    
    func setupUI() {
        view.addSubview(stackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Action
    
    @objc func saveButtonTapped() {
        let plist = UserDefaults.standard
        let nickname = nicknameTextField.text
        plist.set(nickname, forKey: "nickname")
    }

}

// MARK: - Extention

