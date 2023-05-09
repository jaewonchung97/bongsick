//
//  Constant.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/08.
//

import UIKit

struct ThemeAPI {
    static let requestURL = "http://144.24.83.125:8080/theme"
//    static let requestURL = "http://xn--9n3bq0i.xn--h32bi4v.xn--3e0b707e:8080/theme"
}

enum TableView {
    enum Length {
        static let height: CGFloat = 100
    }
    
    enum Cell {
        static let width: CGFloat = TableView.Length.height - 6
    }
}

enum Setup {
    enum Color {
        static let textColor = UIColor.customBlack
        static let backgroundColor = UIColor.white
    }
}
