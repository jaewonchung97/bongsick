//
//  ThemeTableViewCell.swift
//  EscapeRooms
//
//  Created by playhong on 2023/02/23.
//

import UIKit

protocol ThemeTableViewCellDelegate {
    func moveDetailView(indexPath: IndexPath)
}

final class ThemeTableViewCell: UITableViewCell {
    
    static let identifier = "ThemeTableViewCell"
    var delegate: ThemeTableViewCellDelegate?
    
    // MARK: - Properties
    
    var themeArray: [Theme] = []

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ThemeCollectionViewCell.self, forCellWithReuseIdentifier: ThemeCollectionViewCell.identifier)
        cv.backgroundColor = .customBlack
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 오토레이아웃 정하는 정확한 시점 ? 여기에 오토레이아웃 제약을 넣으면 함수 실행이 안됨. 왜 그런지 찾아봐야함.
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    // MARK: - Setting
    
    func configureUI() {
        contentView.addSubview(collectionView)
    }
    
    func setConstraints() {
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    
}

extension ThemeTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCollectionViewCell.identifier, for: indexPath) as? ThemeCollectionViewCell else { return UICollectionViewCell() }
        cell.imageURL = themeArray[indexPath.row].imgURL
        return cell
    }
    
}

extension ThemeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.moveDetailView(indexPath: indexPath)
        print("Theme Table View CollectionView Cell\(#function)")
    }
}
