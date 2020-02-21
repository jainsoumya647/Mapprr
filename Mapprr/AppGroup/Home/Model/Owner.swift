//
//  Owner.swift
//  Mapprr
//
//  Created by Soumya Jain on 21/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation

struct Owner: Codable {
    
    var id: Int
    var avatarURL: String?
    var login: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case avatarURL = "avatar_url"
        case login = "login"
    }
    
    func getAvatarURL() -> String? {
        return self.avatarURL
    }
}
