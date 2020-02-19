//
//  RepoDetailsViewController.swift
//  Mapprr
//
//  Created by Soumya Jain on 20/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel: RepoDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeEvents()
        self.setupViews()
    }
    
    
    func setInitialData(repo: Repository) {
        self.viewModel = RepoDetailsViewModel(repo: repo)
    }
    
    func observeEvents() {
        self.viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupViews() {
        self.setupTableView()
    }
    
    func setupTableView() {
        self.register(table: self.tableView)
        RepoDetailsCell.registerWithTable(self.tableView)
    }
    
    func getConroller(repo: Repository) -> RepoDetailsViewController? {
        guard let vc = UIViewController.initalizeMyViewController(identifier: .repoDetailsViewController, storyboard: .main) as? RepoDetailsViewController else { return nil }
        vc.setInitialData(repo: repo)
        return vc
    }
}

extension RepoDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = RepoDetailsCell.getDequeuedCell(for: tableView, indexPath: indexPath)
            as? RepoDetailsCell else { return UITableViewCell() }
        let (primary, secondary) = self.viewModel.getTexts(on: indexPath.row)
        cell.configureCell(title: primary, description: secondary)
        return cell
    }
}

