//
//  Repository.swift
//  Mapprr
//
//  Created by Soumya Jain on 19/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation

struct SearchRepoResponse:Codable {

    var totalCount: Int
    var items: [Repository]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items = "items"
    }
}

struct Repository: Codable {
    
    var id: Int
    var name: String?
    var fullName: String?
    var watchersCount: Int?
    var owner: Owner?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case watchersCount = "watchers_count"
        case owner = "owner"
    }
    
    func getName() -> String {
        return self.name ?? "-"
    }
    
    func getFullName() -> String {
        return self.fullName ?? "-"
    }
    
    func getWatchersCount() -> String {
        return "\(self.watchersCount ?? 0)"
    }
    
    func getAvatarImage() -> String? {
        return self.owner?.avatarURL
    }
}

struct Owner: Codable {
    
    var avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
