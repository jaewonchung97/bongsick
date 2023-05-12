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
        view.backgroundColor = .customLightOrange
        return view
    }()

    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Setup.Color.backgroundColor
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let topViewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "통계"
        label.textColor = Setup.Color.textColor
        label.font = UIFont.boldSystemFont(ofSize: 22)
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
    
    private let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "탈출 시도"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "80 번"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var totalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [totalTitleLabel, totalLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    private let successTotalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "성공한 테마"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let successTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "75 개"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var successTotalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [successTotalTitleLabel, successTotalLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    private let successRateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "탈출 성공률"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let successRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "75 %"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var successRateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [successRateTitleLabel, successRateLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    
    lazy var mainStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [totalStackView, successTotalStackView, successRateStackView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    private let minClearTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "제일 빠르게 탈출한 테마"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let bottomMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Setup.Color.textColor
        label.text = "성공률"
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
        label.text = "최근 탈출 기록"
        label.textColor = Setup.Color.textColor
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let escapeHistoryTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = Setup.Color.backgroundColor
        tv.isScrollEnabled = false
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
        contentView.addSubview(mainStackView)
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
            topView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            topView.heightAnchor.constraint(equalToConstant: topViewHeight)
        ]
        NSLayoutConstraint.activate(topViewConstraints)
        
        // MARK: - totalStackView
        let mainStackViewConstraints = [
            mainStackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -15),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        NSLayoutConstraint.activate(mainStackViewConstraints)
        
        // MARK: - escapeHistoryTableView
        let escapeHistoryTableViewConstraints = [
            escapeHistoryTableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15),
            escapeHistoryTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            escapeHistoryTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            escapeHistoryTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            escapeHistoryTableView.heightAnchor.constraint(equalToConstant: 450)
        ]
        NSLayoutConstraint.activate(escapeHistoryTableViewConstraints)
    }
    
    // MARK: - Action
}
