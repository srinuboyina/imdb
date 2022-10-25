//
//  ViewController.swift
//  imdb
//
//  Created by apple on 19/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getMovies()
        self.view.bringSubviewToFront(tableView)
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    @IBAction func btnSearchClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            searchVC.modalPresentationStyle = .fullScreen
            searchVC.movies = SharedMovies.shared.movies
            self.present(searchVC, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedMovies.shared.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell {
            let movie = SharedMovies.shared.movies[indexPath.row]
            cell.setData(movie: movie)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.favouriteButton.addTarget(self, action: #selector(setFavourite(button:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            let movie = SharedMovies.shared.movies[indexPath.row]
            movieDetailsVC.movie = movie
            movieDetailsVC.modalPresentationStyle = .fullScreen
            self.present(movieDetailsVC, animated: true)
        }
    }
    
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        let label1 = UILabel(frame: CGRect(x: 30, y: 0, width: 30, height: 20))
        label1.text = "OUR"
        label1.font = UIFont.systemFont(ofSize: 12)
        label1.textColor = .white
        
        view.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 60, y: 0, width: 150, height: 20))
        label2.text = "STAFF PICKS"
        label2.font = UIFont.boldSystemFont(ofSize: 12)
        label2.textColor = .white
        view.addSubview(label2)
        view.backgroundColor = UIColor(red: 0.078, green: 0.11, blue: 0.145, alpha: 1)
        return view
    }
    
    @objc func setFavourite(button: UIButton) {
        if let cell = button.superview?.superview as? MovieCell {
            if let indexPath = tableView.indexPath(for: cell) {
                let movie = SharedMovies.shared.movies[indexPath.row]
                SharedMovies.shared.movies[indexPath.row].favourite = !(movie.favourite  ?? false)
                if let cell = tableView.cellForRow(at: indexPath) as? MovieCell {
                    let image = (movie.favourite ?? false) ? UIImage(named: "selected_tag")! : UIImage(named: "unselected_tag")!
                    cell.favouriteButton.setImage(image, for: .normal)
                }
                collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SharedMovies.shared.favourites.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCell", for: indexPath) as? FavouriteCell {
            let movie = SharedMovies.shared.favourites[indexPath.row]
            if let url  = URL(string: movie.posterUrl) {
                cell.movieImageView.loadImageWithUrl(url)
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                cell.movieImageView.addGestureRecognizer(tapGestureRecognizer)
            }
            cell.backgroundColor = .clear
            return cell
        }
        return UICollectionViewCell()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let tappedImage = tapGestureRecognizer.view as? UIImageView {
            if let cell = tappedImage.superview?.superview as? FavouriteCell {
                if let indexPath = collectionView.indexPath(for: cell) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let movieDetailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
                        let movie = SharedMovies.shared.favourites[indexPath.row]
                        movieDetailsVC.movie = movie
                        movieDetailsVC.modalPresentationStyle = .overFullScreen
                        self.present(movieDetailsVC, animated: true)
                    }
                }
            }
        }
    }

}

extension ViewController: MoviesDelegate {
    func moviesLoaded() {
        tableView.reloadData()
    }
}

