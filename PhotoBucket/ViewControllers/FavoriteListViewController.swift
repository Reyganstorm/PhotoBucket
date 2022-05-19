//
//  FavoriteListViewController.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import UIKit
import RealmSwift

class FavoriteListViewController: UITableViewController {
    
    private var photoElements: Results<RealmResultObject>!

    override func viewDidLoad() {
        super.viewDidLoad()
        createTempData()
        photoElements = StorageManager.shared.localRealm.objects(RealmResultObject.self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        photoElements = StorageManager.shared.localRealm.objects(RealmResultObject.self)
        tableView.reloadData()
    }
    
    private func createTempData() {
        DataManager.shared.createTempData {
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photoElements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        let results = photoElements[indexPath.row]
        cell.imageConfig(results)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let infoVC = segue.destination as? InfoViewController else { return }
            infoVC.realmPhoto = photoElements[indexPath.row]
        }
    }

}
