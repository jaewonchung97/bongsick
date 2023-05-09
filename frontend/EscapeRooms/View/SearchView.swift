//
//  SearchView.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/08.
//

import UIKit

class SearchView: UIView {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
