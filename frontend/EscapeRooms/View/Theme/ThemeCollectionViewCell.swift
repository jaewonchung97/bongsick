//
//  ThemeCollectionViewCell.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/26.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ThemeCollectionViewCell"

    var imageURL: String? {
        didSet {
            guard let url = imageURL else { return }
            NetworkingManager.shared.loadImage(url, imageView: imageView)
        }
    }
    
    // MARK: - Properties
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleToFill
        return iv
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    // MARK: - Setting
    
    func configureUI() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        contentView.addSubview(imageView)
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
