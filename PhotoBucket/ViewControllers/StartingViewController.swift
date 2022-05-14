//
//  StartingViewController.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import UIKit


class StartingViewController: UICollectionViewController {
    
    // MARK: - Private Proporties

    private var photos: [GetingResult] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    let searchObj = SearchObjectManager.shared
    
    private var searchBarIsEmplty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        //fetch()
        
        fetchSearch(text: "box")
    }

 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else {return}
        let photoData = photos[indexPath.row]
        let infoVC = segue.destination as? InfoViewController
        infoVC?.dataPhoto = photoData
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        cell.configuration(photos[indexPath.row])
        return cell
    }

}

extension StartingViewController {
    private func fetch() {
        NetworkManager.shared.fetch(from: Links.start.rawValue) { results in
            switch results {
            case .success(let photoElements):
                self.photos = photoElements
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                print("Упс")
            }
        }
    }
    
    private func fetchSearch(text: String) {
        searchObj.fetch(text: text) { result in
            switch result {
            case .success(let res):
                self.photos = res
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - SearchController
extension StartingViewController {
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension StartingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filteredContentForSearchText(_ search: String) {
        // Продумать логику загрузки
    }
}
