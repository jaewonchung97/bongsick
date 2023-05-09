//
//  resultsTableController.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/09.
//

import UIKit

class ResultsTableController: UISearchController {
    
    var themeArray: [Theme] = []
    var filteredArray: [Theme] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
    }
    
    func configureSearchBar() {
        self.searchResultsUpdater = self
    }
}

// MARK: - Extension

extension ResultsTableController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
    }
}

