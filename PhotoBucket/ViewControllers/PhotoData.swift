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
//    let createdAt, updatedAt: Date
//    let promotedAt: Date?
//    let width, height: Int
//    let color, blurHash: String
//    let photoDescription: String?
//    let altDescription: String?
    let urls: Urls
//    let links: PhotoLinks
//    let categories: [Any?]
//    let likes: Int
//    let likedByUser: Bool
//    let currentUserCollections: [Any?]
//    let sponsorship: Sponsorship?
//    let user: User
}

// MARK: - PhotoLinks
struct PhotoLinks: Decodable {
    let linksSelf, html, download, downloadLocation: String
}

// MARK: - Sponsorship
struct Sponsorship: Decodable {
    let impressionUrls: [String]
    let tagline: String
    let taglineURL: String
    let sponsor: User
}

// MARK: - User
struct User: Decodable {
    let id: String
    let updatedAt: Date
    let username, name, firstName: String
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio: String
    let location: String?
    let links: UserLinks
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int
    let acceptedTos, forHire: Bool
    let social: Social
}

// MARK: - UserLinks
struct UserLinks: Decodable {
    let linksSelf, html, photos, likes: String
    let portfolio, following, followers: String
}

// MARK: - ProfileImage
struct ProfileImage: Decodable {
    let small, medium, large: String
}

// MARK: - Social
struct Social: Decodable {
    let instagramUsername: String?
    let portfolioURL: String?
    let twitterUsername: String?
    let paypalEmail: String?
}



// MARK: - Urls
struct Urls: Decodable {
    let full: String
}

