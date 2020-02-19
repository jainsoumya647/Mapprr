//
//  Contributors.swift
//  Mapprr
//
//  Created by Soumya Jain on 20/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation


struct ContributorsService {
    typealias ContributorsCompletionBlock = (_ model: [Owner]) -> Void
    let router = Router<ApiName>()

    func getContributors(repoName: String, completion: @escaping ContributorsCompletionBlock) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        router.request(.getContributors(repoName)) { (_data, response, _error) in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if let data = _data {
                let decoder = JSONDecoder()
                do {
                    let searchResult = try decoder.decode([Owner].self, from: data)
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
