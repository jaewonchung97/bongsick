//
//  CoreDataManager.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/12.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let likedModelName: String = "LikedData"
    let recordModelName: String = "RecordData"
    
    // MARK: - LikedData

    // MARK: - Create
    func createLikedData(with data: Theme, completion: @escaping() -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.likedModelName, in: context) {
                if let likedTheme = NSManagedObject(entity: entity, insertInto: context) as? LikedData {
                    likedTheme.imageURL = data.imgURL
                    likedTheme.name = data.name
                    likedTheme.company = data.companies[0]
                    likedTheme.difficulty = Int64(data.difficulty)
                    likedTheme.isLiked = data.isLiked
                    appDelegate?.saveContext()
                }
            }
        }
        completion()
    }
    
    // MARK: - Read
    func getLikedDataFromCoreData() -> [LikedData] {
        var LikedDataArray: [LikedData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.likedModelName)
            let dataOrder = NSSortDescriptor(key: "name", ascending: false)
            request.sortDescriptors = [dataOrder]
            do {
                if let fetchedRecord = try context.fetch(request) as? [LikedData] {
                    LikedDataArray = fetchedRecord
                }
            }  catch {
                print("DEBUG: 찜목록 데이터를 가져오지 못했습니다.")
            }
        }
        return LikedDataArray
    }
    
    // MARK: - Liked Data Delete
    func deleteLikedData(data: LikedData, completion: () -> Void) {
        guard let name = data.name else {
            completion()
            return
        }
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.likedModelName)
            request.predicate = NSPredicate(format: "name = %@", name as CVarArg)
            do {
                if let fetchedLikedData = try context.fetch(request) as? [LikedData] {
                    if let target = fetchedLikedData.first {
                        context.delete(target)
                        appDelegate?.saveContext()
                    }
                }
                completion()
            } catch {
                print("DEBUG: 좋아요한 테마를 제거하지 못했습니다.")
                completion()
            }
        }
    }
    
    
    
    
    
    
    // MARK: - Record Create

    func createRecord(result: Bool, theme: String, date: Date, minute: String, second: String, hint: String, text: String?, completion: @escaping() -> Void) {
        if let context = context {
            
            if let entity = NSEntityDescription.entity(forEntityName: self.recordModelName, in: context) {
                
                if let record = NSManagedObject(entity: entity, insertInto: context) as? RecordData {
//                    record.photo = photo
                    record.theme = theme
                    record.date = date
                    record.result = result
                    record.minute = minute
                    record.second = second
                    record.hint = hint
                    record.text = text
                    appDelegate?.saveContext()
                }
            }
        }
        
        completion()
    }
    
    // MARK: - Read

    func getRecordThemesFromCoreData() -> [RecordData] {
        var record: [RecordData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.recordModelName)
            let dataOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dataOrder]
            do {
                if let fetchedRecord = try context.fetch(request) as? [RecordData] {
                    record = fetchedRecord
                }
            }  catch {
                print("DEBUG: fetched Record Themes Fail!!!")
            }
        }
        return record
    }
    
    // MARK: - Update
    
    func updateRecord(updateData: RecordData, completion: () -> Void) {
        guard let date = updateData.date else {
            completion()
            return
        }
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.recordModelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                if let fetchedRecord = try context.fetch(request) as? [RecordData] {
                    if var targetRecord = fetchedRecord.first {
                        targetRecord = updateData
                        appDelegate?.saveContext()
                    }
                }
                completion()
            } catch {
                print("DEBUG: Record Update Failed")
                completion()
            }
        }
    }
    
    // MARK: - Delete
    
    func deleteRecord(data: RecordData, completion: () -> Void) {
        guard let date = data.date else {
            completion()
            return
        }
        
        if let context = context {
            
            let request = NSFetchRequest<NSManagedObject>(entityName: self.recordModelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                if let fetchedRecord = try context.fetch(request) as? [RecordData] {
                    if let targetRecord = fetchedRecord.first {
                        context.delete(targetRecord)
                        appDelegate?.saveContext()
                    }
                }
                completion()
            } catch {
                print("DEBUG: Record Delete Failed!!")
                completion()
            }
        }
    }


    
    
    
    
    
}
