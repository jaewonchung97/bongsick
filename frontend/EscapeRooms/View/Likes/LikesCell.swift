//
//  LikesView.swift
//  EscapeRooms
//
//  Created by playhong on 2023/03/01.
//

import UIKit

protocol LikesCellDelegate {
    func likeButtonTapped(cell: LikesCell, likeState: Bool)
}


final class LikesCell: UITableViewCell {
    
    // MARK: - Properties
    
    var delegate: LikesCellDelegate?
    
    var theme: LikedData? {
        didSet {
            setupData()
        }
    }
    
    // MARK: - Component

    let themeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
     let nameLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 22)
         label.textColor = .black
         label.text = "임시 테마임"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "임시 회사"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let difficultyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let personnelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLabel, companyLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 3
        return sv
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: Button.LikeButton.symbolConfigure), for: .normal)
        button.tintColor = .customOrange
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setConstraints()
    }
    
    // MARK: - Configure
    
    func setupUI() {
        self.backgroundColor = .white
        self.selectionStyle = .none
    }
    
    func addSubviews() {
        contentView.addSubview(themeImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(likeButton)
    }
    
    func setConstraints() {
        let themeImageViewConstraints = [
            themeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            themeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            themeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            themeImageView.widthAnchor.constraint(equalToConstant: 144)
        ]
        NSLayoutConstraint.activate(themeImageViewConstraints)
        
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: themeImageView.trailingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
        
        let likeButtonConstraints = [
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(likeButtonConstraints)
    }
    
    func setupData() {
        guard let url = theme?.imageURL else { return }
        NetworkingManager.shared.loadImage(url, imageView: themeImageView)
        nameLabel.text = theme?.name
        companyLabel.text = theme?.company
    }


    
    // MARK: - Action
    
    @objc func didTapLikeButton() {
        guard let state = theme?.isLiked else { return }
        delegate?.likeButtonTapped(cell: self, likeState: state)
    }
    
}
