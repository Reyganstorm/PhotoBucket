//
//  StorageManager.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 15.05.2022.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    let localRealm = try! Realm()
    private init() {}
    
    // MARK: - Save
    func save(_ photoData: RealmResultObject) {
        write {
            localRealm.add(photoData)
        }
    }
    
    // MARK: - Delete
    func delete(_ photoData: RealmResultObject) {
        write {
            localRealm.delete(photoData)
        }
    }
    
    // MARK: - Private write
    private func write(completion: () -> Void) {
        do {
            try localRealm.write {
                completion()
            }
        } catch let error{
            print(error)
        }
    }
    
    // MARK: - Convertable method
    func convertResult(_ converte: ResultObject) -> RealmResultObject {
        let result = RealmResultObject()
        result.id = converte.id
        result.likes = converte.likes ?? 0
        result.name = converte.user.name
        result.dateString = converte.created_at ?? "0"
        result.url = converte.urls.small
        result.location = converte.user.location ?? "Unknowned"
        
        return result
    }
}
