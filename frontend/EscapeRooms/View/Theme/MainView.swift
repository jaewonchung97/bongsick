//
//  MainView.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/26.
//

import UIKit

class MainView: UIView {
    
    // MARK: - Properties
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ThemeTableViewCell.self, forCellReuseIdentifier: ThemeTableViewCell.identifier)
        tv.backgroundColor = .black
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        return tv
    }()
    
    let titleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let width = UIScreen.main.bounds.size.width - 20
        let height = UIScreen.main.bounds.size.height / 3 - 60
        layout.itemSize = CGSize(width: width, height: height)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .black
        cv.register(BestThemeViewCell.self, forCellWithReuseIdentifier: BestThemeViewCell.identifier)
        return cv
    }()
    
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
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
        self.addSubview(tableView)
        let height = UIScreen.main.bounds.size.height / 3
        titleCollectionView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: height)
        tableView.tableHeaderView = titleCollectionView
    }
    
    func setConstraints() {
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]

        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    // MARK: - Action
    
    
}

// MARK: - Extention



