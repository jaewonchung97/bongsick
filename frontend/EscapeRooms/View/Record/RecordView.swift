//
//  RecordView.swift
//  EscapeRooms
//
//  Created by playhong on 2023/03/30.
//

import UIKit

final class RecordView: UIView {
    
    // MARK: - Properties
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = Setup.Color.backgroundColor
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Setup.Color.backgroundColor
        return view
    }()

    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customOrange
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let topViewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "통계"
        label.textColor = Setup.Color.textColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
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
        label.textColor = Setup.Color.textColor
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var profileStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [profileImageView, nickNameLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    private let topMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "총 86 개의 방탈출을 시도, 그 중 76 개를 성공..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let bottomMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "나의 성공률은 75.6 %!!!!"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .right
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    let progressView = CircularProgressBar()

    private let middleTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "나의 탈출 기록"
        label.textColor = Setup.Color.textColor
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let escapeHistoryTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = Setup.Color.backgroundColor
        tv.layer.cornerRadius = 8
        tv.layer.masksToBounds = true
        return tv
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    // MARK: - Setting
    
    func addSubviews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileStackView)
        contentView.addSubview(topView)
        contentView.addSubview(topViewTitleLabel)
        contentView.addSubview(topMessageLabel)
        contentView.addSubview(bottomMessageLabel)
        contentView.addSubview(middleTitleLabel)
        contentView.addSubview(escapeHistoryTableView)
    }
    
    func setConstraints() {
        
        // MARK: - ScrollView
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
        
        // MARK: - ContentView
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        NSLayoutConstraint.activate(contentViewConstraints)
        
        // MARK: - profileStackView
        let profileStackViewWidth = UIScreen.main.bounds.size.width - 20
        let profileStackViewConstraints = [
            profileStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileStackView.widthAnchor.constraint(equalToConstant: profileStackViewWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(profileStackViewConstraints)
        
        // MARK: - TopView
        let topViewHeight: CGFloat = UIScreen.main.bounds.height / 3
        let topViewConstraints = [
            topView.topAnchor.constraint(equalTo: profileStackView.bottomAnchor, constant: 10),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            topView.heightAnchor.constraint(equalToConstant: topViewHeight)
        ]
        NSLayoutConstraint.activate(topViewConstraints)
        
        // MARK: - TopViewTitleLabel
        let topViewTitleLabelConstraints = [
            topViewTitleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20),
            topViewTitleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(topViewTitleLabelConstraints)
        
        // MARK: - TopMessageLabel
        let topMessageLabelConstraints = [
            topMessageLabel.topAnchor.constraint(equalTo: topViewTitleLabel.bottomAnchor, constant: 10),
            topMessageLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(topMessageLabelConstraints)
        
        // MARK: - bottomMessageLabel
        let bottomMessageLabelConstraints = [
            bottomMessageLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10),
            bottomMessageLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
        ]
        NSLayoutConstraint.activate(bottomMessageLabelConstraints)

        // MARK: - middleTitleLabel
        let middleTitleLabelConstraints = [
            middleTitleLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15),
            middleTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(middleTitleLabelConstraints)
        
        // MARK: - escapeHistoryTableView
        let escapeHistoryTableViewConstraints = [
            escapeHistoryTableView.topAnchor.constraint(equalTo: middleTitleLabel.bottomAnchor, constant: 10),
            escapeHistoryTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            escapeHistoryTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            escapeHistoryTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            escapeHistoryTableView.heightAnchor.constraint(equalToConstant: 400)
        ]
        NSLayoutConstraint.activate(escapeHistoryTableViewConstraints)

    }
    
    // MARK: - Action


}
