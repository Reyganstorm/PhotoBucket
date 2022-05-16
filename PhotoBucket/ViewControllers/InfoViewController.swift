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
    
    var jsonPhoto: ResultObject!
    var realmPhoto: RealmResultObject!
    
    private var photoElements: Results<RealmResultObject>!
    
    var isAddToRealmArchiv: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoElements = StorageManager.shared.localRealm.objects(RealmResultObject.self)
        isAddToRealmArchiv = sortedImages()
        let buttonTitle = isAddToRealmArchiv ? "Delete" : "Save"
        likesButton.setTitle(buttonTitle, for: .normal)
        
        if jsonPhoto != nil {
            
            prepareJSONFilesToView()
            print(jsonPhoto.id)
        }
        
        if realmPhoto != nil {
            prepareRealmFilesToView()
        }
    }
    
    @IBAction func changeStatusButtonPressed(_ sender: UIButton) {
        let alertTittle = "Are you really want to do this"
        let alertMessage = "Chose answer"
        showAlert(title: alertTittle, message: alertMessage)
    }

}

extension InfoViewController {
    private func showAlert(
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel)
        
        let yesAction = UIAlertAction(
            title: "YES",
            style: .default) { _ in
            }
        
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
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
    private func sortedImages() -> Bool {
        if let _ = realmPhoto {
            return true
        } else {
        guard let _ = jsonPhoto else { return false}
        for photo in photoElements {
            if jsonPhoto.id == photo.id {
                return true
            }
        }
        return false
    }
}
}
