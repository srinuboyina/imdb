//
//  RatingCell.swift
//  imdb
//
//  Created by apple on 23/10/22.
//

import UIKit

class RatingCell: UICollectionViewCell {
    @IBOutlet weak var touchView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var ratingView: RatingBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.white.cgColor
        ratingView.layoutIfNeeded()
    }
    
    func setNumberofStars(number: Int) {
        ratingView.setNumberofStars(number: number)
        ratingView.setRating(rating: 0)
    }
    
    func setRating(rating: Double) {
        //ratingView.numStars = 5
        ratingView.setRating(rating: rating)
    }

}
