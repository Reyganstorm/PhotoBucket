//
//  PhotoData.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import Foundation

// MARK: - PhotoElement
struct PhotoElement: Decodable {
    let id: String
    let created_at: String
    let urls: Urls
    let likes: Int
    let liked_by_user: Bool
    let user: User
}

// MARK: - User
struct User: Decodable {
    let name: String
    let location: String?
}

// MARK: - Urls
struct Urls: Decodable {
    let full: String
    let small: String
}

