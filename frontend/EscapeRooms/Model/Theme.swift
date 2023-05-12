//
//  ThemeData.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/08.
//

import UIKit

class Theme: Codable {
    // MARK: - ThemeElement
    let id: String
    let name: String
    let companies: [String]
    let difficulty: Int
    let imgURL: String
    let personnelMax: Int
    let personnelMin: Int
    let playTime: Int
    let story: String
    let genre: String
    let reservationURL: String
    var isLiked: Bool = false
    
    init(id: String, name: String, companies: [String], difficulty: Int, imgURL: String, personnelMax: Int, personnelMin: Int, playTime: Int, story: String, genre: String, reservationURL: String, isLiked: Bool) {
        self.id = id
        self.name = name
        self.companies = companies
        self.difficulty = difficulty
        self.imgURL = imgURL
        self.personnelMax = personnelMax
        self.personnelMin = personnelMin
        self.playTime = playTime
        self.story = story
        self.genre = genre
        self.reservationURL = reservationURL
        self.isLiked = isLiked
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case companies
        case difficulty
        case imgURL = "imgUrl"
        case personnelMax
        case personnelMin
        case playTime
        case story
        case genre
        case reservationURL = "reservationUrl"
    }
}
