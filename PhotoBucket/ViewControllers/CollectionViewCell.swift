//
//  CollectionViewCell.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var imageView: PhotoImage!
    
    
    func configuration(_ photoElement: PhotoElement) {
        textLabel.text = photoElement.id
        imageView.fetch(from: photoElement.urls.full)
    }
}


