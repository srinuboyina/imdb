//
//  MovieDetailsCell.swift
//  imdb
//
//  Created by apple on 22/10/22.
//

import UIKit

class MovieDetailsCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: ImageLoader!
    @IBOutlet weak var ratingBar: RatingBar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tagList: TagListView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setMovie(movie: Movie) {
        if let url = URL(string: movie.posterUrl) {
            movieImageView.loadImageWithUrl(url)
        }
        ratingBar.rating = movie.rating
        dateLabel.text = movie.dateAndTime
        nameLabel.text = movie.title
        yearLabel.text = movie.year
        tagList.removeAllTags()
        tagList.addTags(movie.genres)
    }
}

