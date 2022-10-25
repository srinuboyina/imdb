//
//  MovieCell.swift
//  imdb
//
//  Created by apple on 21/10/22.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImage: ImageLoader!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var ratingBar: RatingBar!
    @IBOutlet weak var favouriteButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layoutIfNeeded()
    }

    func setData(movie: Movie) {
        if let url = URL(string: movie.posterUrl) {
            movieImage.loadImageWithUrl(url)
        }
        yearLabel.text = movie.year
        movieLabel.text = movie.title
        ratingBar.rating = movie.rating
        favouriteButton.setFavourite(favourite: movie.favourite)
    }
}
