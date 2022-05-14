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
        textLabel.text = photoElement.id
        imageView.fetch(from: photoElement.urls.small)
        activityIndicator.hidesWhenStopped = true
    }
}


