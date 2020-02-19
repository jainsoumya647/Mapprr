//
//  CardsService.swift
//  Blog
//
//  Created by Soumya on 13/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import Foundation

struct SearchRepository {
    typealias RepositoriesCompletionBlock = (_ model: [Repository]) -> Void
    let router = Router<ApiName>()

    func getRepositories(searchString: String, completion: @escaping RepositoriesCompletionBlock) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        router.request(.getRepos(searchString)) { (_data, response, _error) in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if let data = _data {
                let decoder = JSONDecoder()
                do {
                    let searchResult = try decoder.decode(SearchRepoResponse.self, from: data)
                    completion(searchResult.items ?? [Repository]())
                } catch {
                    Utility.printErrorAndShowAlert(error: error)
                }
            } else {
                Utility.printErrorAndShowAlert(error: _error)
            }
        }
    }
}
