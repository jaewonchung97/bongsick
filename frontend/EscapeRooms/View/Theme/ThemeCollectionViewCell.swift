//
//  ThemeCollectionViewCell.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/26.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ThemeCollectionViewCell"
    
    var themeData: Theme? {
        didSet {
            configureCell()
        }
    }
    
    // MARK: - Properties
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
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
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    // MARK: - Setting
    
    func configureUI() {
        contentView.addSubview(imageView)
    }
    
    func configureCell() {
        imageView.image = themeData?.image
    }
    
    func setConstraints() {
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    // MARK: - Action


}
