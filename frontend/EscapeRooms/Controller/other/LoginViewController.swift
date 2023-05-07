//
//  LoginViewController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/03/09.
//

import UIKit
import Firebase
import FirebaseAuth

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var handle: AuthStateDidChangeListenerHandle?
    
    let textFieldHeight: CGFloat = 48

    // MARK: - Components
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "house.and.flag.fill")
        iv.tintColor = .orange
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
    
    let loginButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor(red: 221/255, green: 161/255, blue: 94/255, alpha: 1)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 10
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let subStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
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
    
    // MARK: - UISetting
    
    func configureView() {
        self.view.backgroundColor = UIColor(red: 29/255, green: 45/255, blue: 68/255, alpha: 1)
        view.addSubview(logoImageView)
        view.addSubview(mainStackView)
        view.addSubview(subStackView)
    }

    func configureStackView() {
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(loginButton)
        
        subStackView.addArrangedSubview(signUpButton)
        subStackView.addArrangedSubview(passwordResetButton)
        
        NSLayoutConstraint.activate([
            
            logoImageView.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: textFieldHeight*3),
            
            subStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10),
            subStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    // MARK: - Action

    @objc func loginButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] auth, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                // 로그인 성공
                self?.navigationController?.popToRootViewController(animated: true)
//                let nav = UINavigationController(rootViewController: ThemeViewController())
//                self?.navigationController?.pushViewController(nav, animated: true)
            }
        }
    }
    
    @objc func signUpButtonTapped() {
//        let vc = SignUpViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
