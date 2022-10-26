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
    @IBOutlet weak var tagList: TagListView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setMovie(movie: Movie) {
        if let url = URL(string: movie.posterUrl) {
            movieImageView.loadImageWithUrl(url)
        }
        ratingBar.rating = movie.rating
        
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
        let yearString = NSMutableAttributedString(string:movie.year, attributes:attrs)
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)]
        let titleString = NSMutableAttributedString(string:movie.title, attributes:attrs2)
        
        titleString.append(yearString)
        dateLabel.text = movie.dateAndTime
        nameLabel.attributedText = titleString
        tagList.removeAllTags()
        tagList.addTags(movie.genres)
    }
}

