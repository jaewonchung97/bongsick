//
//  LikesView.swift
//  EscapeRooms
//
//  Created by playhong on 2023/03/01.
//

import UIKit

final class LikesCell: UITableViewCell {
    
    // MARK: - Properties

    let likeButtonConfigure = UIImage.SymbolConfiguration(pointSize: 25)
    
    // MARK: - Component

    let image: UIImageView = {
        let iv = UIImageView()
        
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
     let nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
         
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
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
        let sv = UIStackView(arrangedSubviews: [difficultyLabel, playTimeLabel])
        
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart", withConfiguration: likeButtonConfigure), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 오토레이아웃 정하는 정확한 시점 ? 여기에 오토레이아웃 제약을 넣으면 함수 실행이 안됨. 왜 그런지 찾아봐야함.
    override func updateConstraints() {
        print(#function)
        setConstraints()
        super.updateConstraints()
    }
    
    // MARK: - Configure
    
    func setupUI() {
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.selectionStyle = .none
        
        self.addSubview(image)
        self.addSubview(nameLabel)
        self.addSubview(companyLabel)
        self.addSubview(personnelLabel)
        self.addSubview(stackView)
        // 버튼은 cell 에 추가하지 않고, contentView 위에 버튼을 추가해야 상호작용이 가능하다.
        self.contentView.addSubview(likeButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            image.heightAnchor.constraint(equalToConstant: 120),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
     
            companyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            companyLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 3),
            stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            
            personnelLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 3),
            personnelLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            
            likeButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            likeButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
        ])
    }


    
    // MARK: - Action
    
    @objc func didTapLikeButton() {
        
//        delegate?.cell(self, didLike: <#T##Theme#>)
    }
    
}
