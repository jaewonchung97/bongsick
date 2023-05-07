//
//  ThemeTitleViewCell.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/27.
//

import UIKit

class BestThemeViewCell: UICollectionViewCell {
    
    static let identifier = "BestThemeViewCell"
    
    // MARK: - Properties

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이번주 인기 테마 BEST 5"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel, imageView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    func configureUI() {
        imageView.image = UIImage(named: "강남목욕탕.png")
        contentView.addSubview(stackView)
    }
    
    func setConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
    }

}
