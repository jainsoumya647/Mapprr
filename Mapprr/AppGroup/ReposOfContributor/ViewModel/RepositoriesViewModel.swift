//
//  RepositoriesViewModel.swift
//  Mapprr
//
//  Created by Soumya Jain on 21/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation

class RepositoriesViewModel {
    
    var reloadData: (() -> Void)?
    var owner: Owner
    private var repositories: [Repository]? {
        didSet {
            self.reloadData?()
        }
    }
    
    init(owner: Owner) {
        self.owner = owner
        self.getRepositories(owner: owner)
    }
    
    func getAvatarImage() -> String? {
        return self.owner.avatarURL
    }
    
    func getRepositories(owner: Owner) {
        if let user = owner.login {
            RepositoryService().getRepositories(of: user) { (repositories) in
                self.repositories = repositories
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return self.repositories?.count ?? 0
    }
    
    func getRepositories(on index: Int) -> Repository? {
        return self.repositories?[index]
    }
}
