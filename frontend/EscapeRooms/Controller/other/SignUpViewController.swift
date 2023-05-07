//
//  SignUpViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/03/09.
//

import UIKit
import FirebaseAuth

final class SignUpViewController: UIViewController {

    // MARK: - Properties
    
    let textFieldHeight: CGFloat = 48

    
    // MARK: - Componets
    
    var nicknameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.placeholder = " 닉네임을 입력해주세요."
        tf.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var emailTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.placeholder = " 아이디를 입력해주세요."
        tf.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.placeholder = " 비밀번호를 입력해주세요."
        tf.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 29/255, green: 45/255, blue: 68/255, alpha: 1)
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureStackView()

    }
    
    // MARK: - SettingUI
    
    func configureView() {
        view.backgroundColor = .orange
        view.addSubview(stackView)
    }
    
    func configureStackView() {
        
        stackView.addArrangedSubview(nicknameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signUpButton)
        
        NSLayoutConstraint.activate([
                        
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: textFieldHeight*4)
        ])
    }
    
    
    // MARK: - Actions

    @objc func signUpButtonTapped() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            if user != nil {
                self.dismiss(animated: true)
            } else {
                print("가입 실패")
            }
        }
    }

}
