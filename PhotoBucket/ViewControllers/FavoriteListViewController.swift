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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let results = photoElements[indexPath.row]
        content.text = results.name 
        
        cell.contentConfiguration = content

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
