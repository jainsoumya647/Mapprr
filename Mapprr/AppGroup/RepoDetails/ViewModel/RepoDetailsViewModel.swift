//
//  RepoDetailsViewModel.swift
//  Mapprr
//
//  Created by Soumya Jain on 20/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation

class RepoDetailsViewModel {
    
    private var repository: Repository
    var reloadData: (() -> Void)?
    private var owners: [Owner]? {
        didSet {
            self.reloadData?()
        }
    }
    init(repo: Repository) {
        self.repository = repo
        self.getContributors(repo: repo)
    }
    
    func getNumberOfItems() -> Int {
        return self.owners?.count ?? 0
    }
    
    func getRepositoryName() -> String {
        return self.repository.getFullName()
    }
    
    func getDescription() -> String {
        return self.repository.getDescription()
    }
    
    func getOwner(for index: Int) -> Owner? {
        return self.owners?[index]
    }
    
    func getAvatarImage() -> String? {
        return self.repository.owner?.avatarURL
    }
    
    func getContributors(repo: Repository) {
        ContributorsService().getContributors(repoName: repo.getFullName()) { (owners) in
            self.owners = owners
        }
    }
}
