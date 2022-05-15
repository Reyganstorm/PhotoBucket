//
//  StartingViewController.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import UIKit


class StartingViewController: UICollectionViewController {
    
    // MARK: - Private Proporties

    private var photos: [ResultObject] = []
    private var searchesPhotos: [ResultObject] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        fetch()
        
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
        isFiltering ? searchesPhotos.count : photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        let photo = isFiltering ? searchesPhotos[indexPath.row] : photos[indexPath.row]
        cell.configuration(photo)
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
        SearchObjectManager.shared.fetch(text: text) { result in
            switch result {
            case .success(let res):
                self.searchesPhotos = res
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
        fetchSearch(text: search)
    }
}

extension StartingViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
//        let image = cell.imageView.fetch(from: photos[indexPath.row].urls.small)
        
        let image = UIImage(named: "\(photos[indexPath.row].urls.small)")
        
        if let height = image?.size.height {
            return height
        }
        
        return 0.0
    }
    
}
