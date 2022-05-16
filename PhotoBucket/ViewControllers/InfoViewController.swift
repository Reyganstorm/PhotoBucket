//
//  InfoViewController.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet private var photoImageView: PhotoImage!
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    
    @IBOutlet private var likesButton: UIButton!
    
    var jsonPhoto: ResultObject!
    var realmPhoto: RealmResultObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if jsonPhoto != nil {
            prepareJSONFilesToView()
        }
        
        if realmPhoto != nil {
            prepareRealmFilesToView()
        }
    }
    
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
