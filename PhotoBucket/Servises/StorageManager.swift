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
}
