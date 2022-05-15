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
    
    var dataPhoto: ResultObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.fetch(from: dataPhoto.urls.small)
        nameLabel.text = dataPhoto.user.name

    }
}
