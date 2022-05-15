//
//  TableViewCell.swift
//  PhotoBucket
//
//  Created by Руслан Штыбаев on 13.05.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet var imagePh: PhotoImage!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func imageConfig(_ photoElement: RealmResultObject) {
        imagePh.fetch(from: photoElement.url)
        nameLabel.text = photoElement.name
        imagePh.clipsToBounds = true
        imagePh.layer.cornerRadius = 15
        imagePh.contentMode = .scaleAspectFill
    }
}
