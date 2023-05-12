//
//  SearchViewTableViewCell.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/08.
//

import UIKit

protocol SearchViewTableViewCellDelegate {
    func likeButtonTapped(cell: SearchViewTableViewCell, isLiked: Bool)
}

class SearchViewTableViewCell: UITableViewCell {
    
    static let identifier = "SearchViewTableViewCell"
    
    // MARK: - Properties
    
    var delegate: SearchViewTableViewCellDelegate?
    
    var theme: Theme? {
        didSet {
            setupData()
        }
    }
    
    let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLabel, companyLabel, difficultyLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 3
        return sv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .customBlack
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .customBlack
        return label
    }()
    
    let difficultyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let personnelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        addSubViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
    
    func addSubViews() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(likeButton)
    }
    
    func setConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
        
        let themeImageViewConstraints = [
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            mainImageView.widthAnchor.constraint(equalToConstant: TableView.Cell.width)
        ]
        NSLayoutConstraint.activate(themeImageViewConstraints)
        
        let likeButtonConstraints = [
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(likeButtonConstraints)
    }
    
    func setupButton() {
        if theme?.isLiked == false {
            likeButton.setImage(UIImage(systemName: "heart", withConfiguration: Button.LikeButton.symbolConfigure), for: .normal)
            likeButton.tintColor = .lightGray
        } else {
            likeButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: Button.LikeButton.symbolConfigure), for: .normal)
            likeButton.tintColor = .customOrange
        }
    }
    
    func setupData() {
        guard let url = theme?.imgURL else { return }
        NetworkingManager.shared.loadImage(url, imageView: mainImageView)
        nameLabel.text = theme?.name
        companyLabel.text = theme?.companies[0]
        difficultyLabel.text = ""
    }
    
    // MARK: - Action
    @objc func likeButtonTapped() {
        guard let state = theme?.isLiked else { return }
        delegate?.likeButtonTapped(cell: self, isLiked: state)
    }

}
