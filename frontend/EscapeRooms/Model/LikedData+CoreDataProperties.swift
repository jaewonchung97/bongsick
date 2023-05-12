//
//  LikedData+CoreDataProperties.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/11.
//
//

import Foundation
import CoreData


extension LikedData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedData> {
        return NSFetchRequest<LikedData>(entityName: "LikedData")
    }

    @NSManaged public var name: String?
    @NSManaged public var difficulty: Int64
    @NSManaged public var company: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var isLiked: Bool

}

extension LikedData : Identifiable {

}
