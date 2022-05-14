//
//  Results.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 14.05.2022.
//

import Foundation

struct Results: Decodable {
    let total: Int
    let results: [GetingResult]
}

struct GetingResult: Decodable {
    let id: String
    let description: String?
    let urls: URLs
    
    let created_at: String?
    let likes: Int?
    let liked_by_user: Bool?
    let user: User
}

// MARK: - User
struct User: Decodable {
    let name: String
    let location: String?
}

// MARK: - Urls
struct URLs: Decodable {
    let small: String
}