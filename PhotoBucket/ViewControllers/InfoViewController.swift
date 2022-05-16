//
//  InfoViewController.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet var photoImageView: PhotoImage!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet weak var likesButton: UIButton!
    
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
        nameLabel.text = jsonPhoto.user.name
    }
    
    private func prepareRealmFilesToView() {
        photoImageView.fetch(from: realmPhoto.url)
        nameLabel.text = realmPhoto.name
    }
}
