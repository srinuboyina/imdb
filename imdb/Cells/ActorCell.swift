//
//  ActorCell.swift
//  imdb
//
//  Created by apple on 22/10/22.
//

import UIKit

class ActorCell: UICollectionViewCell {
    
    @IBOutlet weak var actorImageView: ImageLoader!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        actorImageView.layoutIfNeeded()
    }
    
    func setActor(actor: Actor) {
        if let url  = URL(string: actor.pictureUrl) {
            actorImageView.loadImageWithUrl(url)
        }
        nameLabel.text = actor.name
        roleLabel.text = actor.character
    }
    
}
