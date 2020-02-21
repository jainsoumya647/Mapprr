//
//  HomeViewController.swift
//  Mapprr
//
//  Created by Soumya Jain on 19/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalizeData()
        self.observeEvents()
        self.setupViews()
    }

    private func initalizeData() {
        self.viewModel = HomeViewModel()
    }
    
    private func observeEvents() {
        self.viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupViews() {
        self.searchBar.delegate = self
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.register(table: self.tableView)
        HomeCell.registerWithTable(self.tableView)
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = HomeCell.getDequeuedCell(for: tableView, indexPath: indexPath) as? HomeCell
            else { return UITableViewCell() }
        guard let repo = self.viewModel.getRepo(on: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(repo: repo)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let repo = self.viewModel.getRepo(on: indexPath.row),
            let vc = RepoDetailsViewController.getConroller(repo: repo) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        self.view.endEditing(true)
        self.viewModel.searchRepository(text: searchText)
    }
    
}
