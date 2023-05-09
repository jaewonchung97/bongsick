//
//  ThemeData.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/08.
//

import UIKit

struct Theme: Codable {
    let id: String
    let name: String
    let companyID: String
    let difficulty: Int
    let imgURL: String
    let personnelMax: Int
    let personnelMin: Int
    let playTime: Int
    let story: String
    let genre: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case companyID = "companyId"
        case difficulty
        case imgURL = "imgUrl"
        case personnelMax = "personnel_max"
        case personnelMin = "personnel_min"
        case playTime
        case story
        case genre
    }
}
