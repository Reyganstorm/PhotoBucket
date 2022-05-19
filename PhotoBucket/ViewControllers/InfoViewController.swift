//
//  InfoViewController.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import UIKit
import RealmSwift

class InfoViewController: UIViewController {

    @IBOutlet private var photoImageView: PhotoImage!
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    
    @IBOutlet private var likesButton: UIButton!
    
    // MARK: - Prepared Objects
    var jsonPhoto: ResultObject!
    var realmPhoto: RealmResultObject!
    
    // MARK: - Objects for sorting
    private var photoElements: Results<RealmResultObject>!
    var isAddToRealmArchiv: Bool = false
    
    // MARK: - Object for work
    private var objectForWork: RealmResultObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoElements = StorageManager.shared.localRealm.objects(RealmResultObject.self)
        isAddToRealmArchiv = sortedImages() { photo in
            self.objectForWork = photo
        }
        let buttonTitle = isAddToRealmArchiv ? "Delete" : "Save"
        likesButton.setTitle(buttonTitle, for: .normal)
        
        if jsonPhoto != nil {
            prepareJSONFilesToView()
        }
        
        if realmPhoto != nil {
            prepareRealmFilesToView()
        }
    }
    
    @IBAction func changeStatusButtonPressed(_ sender: UIButton) {
        let alertTittle = isAddToRealmArchiv ? "Delete" : "Add"
        showAlert(title: "Are you really want to \(alertTittle) this", objStatus: isAddToRealmArchiv)
    }
}

extension InfoViewController {
    private func showAlert(
        title: String,
        objStatus: Bool
    ) {
        let alert = UIAlertController(
            title: title,
            message: "Make a choice",
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel)
        
        let yesAction = UIAlertAction(
            title: "YES",
            style: .default) { _ in
                if objStatus == false {
                    self.objectForWork = StorageManager.shared.convertResult(self.jsonPhoto)
                    StorageManager.shared.save(self.objectForWork)
                    self.likesButton.setTitle("Delete", for: .normal)
                    self.isAddToRealmArchiv.toggle()
                    self.showSimpleAlert(message: "The photo has been added to the collection")
                } else {
                    StorageManager.shared.delete(self.objectForWork)
                    self.likesButton.setTitle("Add", for: .normal)
                    self.isAddToRealmArchiv.toggle()
                    self.showSimpleAlert(message: "Photo has been removed")
                }
            }
        
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func showSimpleAlert(
        message: String
    ) {
        let alert = UIAlertController(
            title: "Succses",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .cancel)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension InfoViewController {
    private func prepareJSONFilesToView() {
        photoImageView.fetch(from: jsonPhoto.urls.small)
        likesLabel.text = "❤️ \(jsonPhoto.likes ?? 0)"
        nameLabel.text = jsonPhoto.user.name
        locationLabel.text = """
        Location:
        \(jsonPhoto.user.location ?? "Planet Earht")
        """
        
        let dateJ = DateManager.shared.changeWrongStringDateToRight(jsonPhoto.created_at ?? "Un")
        dateLabel.text =
        """
        Date of creating:
        \(dateJ)
        """
    }
    
    private func prepareRealmFilesToView() {
        photoImageView.fetch(from: realmPhoto.url)
        likesLabel.text = "❤️ \(realmPhoto.likes)"
        nameLabel.text = realmPhoto.name
        locationLabel.text = """
        Location:
        \(realmPhoto.location)
        """
        let datePh = DateManager.shared.getStrFromDate(realmPhoto.dateSome)

        dateLabel.text =
        """
        Date of creating:
        \(datePh)
        """
    }
}

extension InfoViewController {
    private func sortedImages(completion: @escaping(RealmResultObject) -> Void) -> Bool {
        if let photo = realmPhoto {
            completion(photo)
            return true
        } else {
            guard let _ = jsonPhoto else { return false}
            for photo in photoElements {
                if jsonPhoto.id == photo.id {
                    completion(photo)
                    return true
                }
            }
            return false
        }
    }
}
