//
//  RepositoryService.swift
//  Mapprr
//
//  Created by Soumya Jain on 21/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation

struct RepositoryService {
    typealias RepositoryCompletionBlock = (_ model: [Repository]) -> Void
    let router = Router<ApiName>()

    func getRepositories(of user: String, completion: @escaping RepositoryCompletionBlock) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        router.request(.getReposOfUser(user)) { (_data, response, _error) in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if let data = _data {
                let decoder = JSONDecoder()
                do {
                    let searchResult = try decoder.decode([Repository].self, from: data)
                    completion(searchResult)
                } catch {
                    Utility.printErrorAndShowAlert(error: error)
                }
            } else {
                Utility.printErrorAndShowAlert(error: _error)
            }
        }
    }
}
