//
//  RealmResults.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 15.05.2022.
//

import Foundation
import RealmSwift

class RealmResultObject: Object {
    @Persisted var id: String = ""

    
    @Persisted var created_at: String = ""
    @Persisted var likes: Int = 0
    @Persisted var liked_by_user: Bool = false
    
    @Persisted var url = ""
    
    @Persisted var dateString = ""
    @Persisted var dateSome = Date()
    
    @Persisted var name: String = ""
    @Persisted var location: String = ""
}
