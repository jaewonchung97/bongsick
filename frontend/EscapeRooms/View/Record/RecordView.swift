//
//  RecordView.swift
//  EscapeRooms
//
//  Created by playhong on 2023/03/30.
//

import UIKit

final class RecordView: UIView {
    
    // MARK: - Properties

    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customBlack
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.image = UIImage(named: "흙길.png")
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private var nickNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "최탈출탈출님의 기록실"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private let totalCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let totalCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "총 86 개의 방탈출을 시도, 그 중 76 개를 성공..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let successRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let successRate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "나의 성공률은 75.6 %!!!!"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .right
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    let progressView = CircularProgressBar()
    
    private lazy var profileStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [profileImageView, nickNameLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    private let escapeHistoryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "나의 탈출 기록"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let escapeHistoryTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .customBlack
        tv.layer.cornerRadius = 8
        tv.layer.masksToBounds = true
        return tv
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    // MARK: - Setting
    
    func setupUI() {
        self.addSubview(mainView)
        mainView.addSubview(profileStackView)
        mainView.addSubview(totalCountLabel)
        mainView.addSubview(totalCount)
        mainView.addSubview(progressView)
        mainView.addSubview(successRateLabel)
        mainView.addSubview(successRate)
        self.addSubview(escapeHistoryTitle)
        self.addSubview(escapeHistoryTableView)
    }
    
    func setConstraints() {
        
        let mainViewHeight: CGFloat = UIScreen.main.bounds.height / 3
        let profileStackViewWidth = UIScreen.main.bounds.width
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            mainView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            mainView.heightAnchor.constraint(equalToConstant: mainViewHeight),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            
            profileStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            profileStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            profileStackView.widthAnchor.constraint(equalToConstant: profileStackViewWidth),
            
            totalCountLabel.topAnchor.constraint(equalTo: profileStackView.bottomAnchor, constant: 10),
            totalCountLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 30),
            
            totalCount.topAnchor.constraint(equalTo: totalCountLabel.bottomAnchor, constant: 5),
            totalCount.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            successRateLabel.topAnchor.constraint(equalTo: totalCount.bottomAnchor, constant: 5),
            successRateLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 100),
            
            successRate.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            successRate.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

            progressView.topAnchor.constraint(equalTo: successRateLabel.bottomAnchor, constant: 10),
            progressView.widthAnchor.constraint(equalToConstant: 130),
            progressView.heightAnchor.constraint(equalToConstant: 130),
            progressView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            escapeHistoryTitle.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 15),
            escapeHistoryTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            escapeHistoryTableView.topAnchor.constraint(equalTo: escapeHistoryTitle.bottomAnchor, constant: 10),
            escapeHistoryTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            escapeHistoryTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            escapeHistoryTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Action


}
