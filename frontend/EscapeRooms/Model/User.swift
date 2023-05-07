//
//  User.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/26.
//

import UIKit

struct User {
    var nickname: String
    var prfileImage: UIImage
    
    var userInfoIsVaild: Bool {
        return UserDefaults.standard.bool(forKey: "")
    }
}
