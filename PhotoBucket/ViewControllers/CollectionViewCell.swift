//
//  CollectionViewCell.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: PhotoImage!
    
    func configuration(_ photoElement: ResultObject) {
        activityIndicator.startAnimating()
        textLabel.text = photoElement.user.name
        imageView.fetch(from: photoElement.urls.small)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        activityIndicator.hidesWhenStopped = true
    }
    
    func imageConfig(_ photoElement: ResultObject) {
        imageView.fetch(from: photoElement.urls.small)
    }
}


