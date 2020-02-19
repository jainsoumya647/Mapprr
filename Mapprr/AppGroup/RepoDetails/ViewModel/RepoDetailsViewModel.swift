//
//  RepoDetailsViewModel.swift
//  Mapprr
//
//  Created by Soumya Jain on 20/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation

class RepoDetailsViewModel {
    
    enum RepoDetailsType {
        case name
        case link
        case description
    }
    
    var repository: Repository
    var rows: [RepoDetailsType]
    var reloadData: (() -> Void)?
    
    init(repo: Repository) {
        self.repository = repo
        self.rows = [.name, .link, .description]
    }
    
    func getTexts(on index: Int) -> (String, String) {
        
        switch self.rows[index] {
        case .name:
            return ("Name: \(self.repository.getName())", "")
        case .link:
            return ("Link: Click Here", "")
        case .description:
            return ("Description:", "\(self.repository.getDescription())")
        }
        
    }
    
    func getNumberOfRows() -> Int {
        return self.rows.count
    }
}
