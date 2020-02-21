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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: RepoDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeEvents()
        self.setupNavigationBar()
        self.setupViews()
    }
    
    
    func setInitialData(repo: Repository) {
        self.viewModel = RepoDetailsViewModel(repo: repo)
    }
    
    func observeEvents() {
        self.viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func setupNavigationBar() {
        self.setNavigationView(title: "Repository Details", leftButtonImage: Image.back)
    }
    
    func setupViews() {
        self.profileImage.kf.setImage(with: URL(string: self.viewModel.getAvatarImage() ?? ""), placeholder: Image.placeholder)
        
        self.nameLabel.text = self.viewModel.getRepositoryName()
        self.descriptionLabel.text = self.viewModel.getDescription()
        
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.register(collectionView)
        ContributorCollectionCell.registerWithCollection(collectionView)
    }
    
    class func getConroller(repo: Repository) -> RepoDetailsViewController? {
        guard let vc = UIViewController.initalizeMyViewController(identifier: .repoDetailsViewController, storyboard: .main) as? RepoDetailsViewController else { return nil }
        vc.setInitialData(repo: repo)
        return vc
    }
    
    @IBAction func projectLinkAction(_ sender: Any) {
        if let urlString = self.viewModel.getHTMLURL(), let vc = WebView.getController(urlString: urlString) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension RepoDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = ContributorCollectionCell.getDequeuedCell(for: collectionView, indexPath: indexPath)
            as? ContributorCollectionCell,
            let owner = self.viewModel.getOwner(for: indexPath.item) else { return UICollectionViewCell() }
        cell.configureCollectionCell(owner: owner)
        return cell
    }
}

extension RepoDetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Height.collectionHeight, height: Height.collectionHeight+30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let owner = self.viewModel.getOwner(for: indexPath.item),
            let vc = RepositoriesViewController.getConroller(owner: owner) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension RepoDetailsViewController: NavigationHeaderProtocol {
    func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
