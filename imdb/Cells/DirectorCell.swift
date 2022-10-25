//
//  DirectorCell.swift
//  imdb
//
//  Created by apple on 23/10/22.
//

import UIKit

class DirectorCell: UITableViewCell {
    
    @IBOutlet weak var directorImageView: ImageLoader!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setDirector(director: Director) {
        directorImageView.layoutIfNeeded()
        if let url = URL(string: director.pictureUrl) {
            directorImageView.loadImageWithUrl(url)
        }
        nameLabel.text = director.name
    }
}
