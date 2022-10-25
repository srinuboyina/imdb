//
//  KeyFactsCell.swift
//  imdb
//
//  Created by apple on 22/10/22.
//

import UIKit

class KeyFactsCell: UITableViewCell {
    
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        view1.layoutIfNeeded()
        view2.layoutIfNeeded()
        view3.layoutIfNeeded()
        view4.layoutIfNeeded()
    }
    
    func setMovie(movie: Movie) {
        budgetLabel.text = movie.budget.toCurrencyFormat()
        revenueLabel.text = movie.revenue?.toCurrencyFormat()
        languageLabel.text = movie.originalLanguage
        ratingLabel.text = movie.ratingValue
    }
}
