//
//  ActorsCell.swift
//  imdb
//
//  Created by apple on 23/10/22.
//

import UIKit

class ActorsCell: UITableViewCell {

    var movie: Movie!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "ActorCell", bundle: nil), forCellWithReuseIdentifier: "ActorCell")
    }
    
    func setMovie(movie: Movie) {
        self.movie = movie
        collectionView.reloadData()
    }
}

extension ActorsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.cast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as? ActorCell {
            let actor = movie.cast[indexPath.row]
            cell.setActor(actor: actor)
            cell.backgroundColor = .clear
            return cell
        }
        return UICollectionViewCell()
    }
}
