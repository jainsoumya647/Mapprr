//
//  HomeViewModel.swift
//  Mapprr
//
//  Created by Soumya Jain on 19/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var reloadData: (() -> Void)?
    var repositories: [Repository]? {
        didSet {
            self.reloadData?()
        }
    }
    
    func searchRepository(text: String) {
        SearchRepository().getRepositories(searchString: text) { (repositories) in
            self.repositories = self.sortReposAndSetLimit(fromRepos: repositories)
        }
    }
    
    func sortReposAndSetLimit(to limit: Int = 10, fromRepos repos: [Repository]) -> [Repository] {
        var topRepos = repos.prefix(limit)
        topRepos.sort { (r1, r2) -> Bool in
            return (r1.watchersCount ?? 0) > (r2.watchersCount ?? 0)
        }
        return Array(topRepos)
    }
    
    func getRepo(on index: Int) -> Repository? {
        return self.repositories?[index]
    }
    
    func getNumberOfRows() -> Int {
        return self.repositories?.count ?? 0
    }
}
