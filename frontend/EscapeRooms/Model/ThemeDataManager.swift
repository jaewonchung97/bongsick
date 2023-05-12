//
//  ThemesManager.swift
//  EscapeRooms
//
//  Created by playhong on 2023/02/23.
//

import UIKit

final class ThemeDataManager {
    
    static let shared = ThemeDataManager()
    
    private init() {
        fetchLikedThemeFromCoreData {
        }
    }
    private let networkManager = NetworkingManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    var themeArrays: [Theme] = []
    
    var likedThemeArray: [LikedData] = []
    
    func getThemeArraysFromAPI() -> [Theme] {
        checkLikedTheme()
        return themeArrays
    }
    
    func getLikedThemeArraysFromCoreData() -> [LikedData] {
        return likedThemeArray
    }
    
    func setupDataFromAPI(completion: @escaping () -> Void) {
        getDatasFromAPI {
            completion()
        }
    }
    
    func getDatasFromAPI(completion: @escaping () -> Void) {
        networkManager.fetchTheme { result in
            switch result {
            case Result.success(let themeData):
                self.themeArrays = themeData
                completion()
            case Result.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveLikedTheme(with theme: Theme, completion: @escaping () -> Void) {
        coreDataManager.createLikedData(with: theme) {
            self.fetchLikedThemeFromCoreData {
                completion()
            }
        }
    }
    
    func cancelLikedTheme(with theme: Theme, completion: @escaping () -> Void) {
        let likedTheme = likedThemeArray.filter { $0.name == theme.name }
        if let target = likedThemeArray.first {
            self.cancelLikedThemeFromCoreData(with: target) {
                completion()
                print("좋아하는 데이터가 추가되었습니다.")
            }
        } else {
            completion()
            print("저장된 데이터가 없네용")
        }
    }
    
    func cancelLikedThemeFromCoreData(with theme: LikedData, completion: @escaping () -> Void
    ) {
        coreDataManager.deleteLikedData(data: theme) {
            self.fetchLikedThemeFromCoreData {
                completion()
            }
            completion()
        }
    }
    
    func fetchLikedThemeFromCoreData(competion: () -> Void) {
        likedThemeArray = coreDataManager.getLikedDataFromCoreData()
        competion()
    }
    
    func checkLikedTheme() {
        themeArrays.forEach { theme in
            if likedThemeArray.contains(where: {
                $0.name == theme.name
            }) {
                theme.isLiked = true
            }
        }
    }
}
