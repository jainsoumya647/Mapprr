//
//  RepositoriesViewController.swift
//  Mapprr
//
//  Created by Soumya Jain on 21/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RepositoriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeEvents()
        self.setupNavigationBar()
        self.setupViews()
    }
    
    func setInitialData(owner: Owner) {
        self.viewModel = RepositoriesViewModel(owner: owner)
    }
    
    func setupNavigationBar() {
        self.setNavigationView(title: "Contributors Details", leftButtonImage: Image.back)
    }
    
    func observeEvents() {
        self.viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupViews() {
        self.imageView.kf.setImage(with: URL(string: self.viewModel.getAvatarImage() ?? ""), placeholder: Image.placeholder)
        
        self.setupTableView()
    }
    
    func setupTableView() {
        self.register(table: self.tableView)
        RepositoryCell.registerWithTable(self.tableView)
    }
    
    class func getConroller(owner: Owner) -> RepositoriesViewController? {
        guard let vc = UIViewController.initalizeMyViewController(identifier: .repositoriesViewController, storyboard: .main) as? RepositoriesViewController else { return nil }
        vc.setInitialData(owner: owner)
        return vc
    }
}

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = RepositoryCell.getDequeuedCell(for: tableView, indexPath: indexPath) as? RepositoryCell,
            let repository = self.viewModel.getRepositories(on: indexPath.row)
            else { return UITableViewCell() }
        cell.configureCell(title: "\(repository.getFullName())")
        return cell
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let repo = self.viewModel.getRepositories(on: indexPath.row),
            let vc = RepoDetailsViewController.getConroller(repo: repo) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var frame = tableView.frame
        frame.size.height = 30
        frame.origin.y = 0
        let headerView = UIView(frame: frame)
        frame.origin.x = 20
        let label = UILabel(frame: frame)
        label.text = "Repositories"
        headerView.addSubview(label)
        return headerView
    }
}

extension RepositoriesViewController: NavigationHeaderProtocol {
    func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
