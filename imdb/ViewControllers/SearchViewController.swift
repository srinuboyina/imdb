//
//  SearchViewController.swift
//  imdb
//
//  Created by apple on 23/10/22.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var bubbleCollectionView: UICollectionView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var noMoviesView: UIView!
    
    var movies: [Movie] = SharedMovies.shared.movies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setBackButtonForSearchField()
        searchTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        bubbleCollectionView.register(UINib(nibName: "RatingCell", bundle: nil), forCellWithReuseIdentifier: "RatingCell")
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let searchText = searchTextField.text, searchText.isEmpty {
            movies = SharedMovies.shared.movies
        } else {
            movies = movies.filter { $0.title.lowercased().contains(textField.text?.lowercased() ?? "") }
        }
        toggleViews()
        searchTableView.reloadData()
    }
    
    private func toggleViews() {
        if (movies.count == 0) {
            searchTableView.isHidden = true
            noMoviesView.isHidden = false
        } else {
            searchTableView.isHidden = false
            noMoviesView.isHidden = true
        }
    }
    
    private func setBackButtonForSearchField() {
        let imageWidth = 25
        let padding = 15
        let imageView = UIImageView(image: UIImage(named: "arrow"))
        imageView.frame = CGRect(x: padding, y: 0, width: imageWidth, height: imageWidth)
        imageView.contentMode = .center
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: imageWidth))
        containerView.addSubview(imageView)
        searchTextField.leftView = containerView
        searchTextField.leftViewMode = .always
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: false)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell {
            let movie = movies[indexPath.row]
            cell.setData(movie: movie)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            let movie = movies[indexPath.row]
            movieDetailsVC.movie = movie
            movieDetailsVC.modalPresentationStyle = .fullScreen
            self.present(movieDetailsVC, animated: true)
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RatingCell", for: indexPath) as? RatingCell {
            cell.setNumberofStars(number: 5 - indexPath.row)
            cell.backgroundColor = .clear
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ratingTapped(tapGestureRecognizer:)))
            cell.touchView.addGestureRecognizer(tapGestureRecognizer)
            return cell
        }
        return UICollectionViewCell()
    }
    
    @objc func ratingTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let bgView = tapGestureRecognizer.view {
            var rating = 0
            if let cell = bgView.superview?.superview as? RatingCell {
                if cell.ratingView.rating > 0 {
                    cell.setRating(rating: 0)
                    filterMoviesWithRating(rating: 0)
                } else {
                    cell.setRating(rating: 5)
                    rating = cell.ratingView.maxStars ?? 1
                    
                }
                filterMoviesWithRating(rating: Double(rating))
            }
        }
    }
    
    func filterMoviesWithRating(rating: Double) {
        if rating == 0 {
            movies = SharedMovies.shared.movies
        } else {
            movies = movies.filter { $0.rating.rounded() == rating }
        }
        toggleViews()
        searchTableView.reloadData()
    }
}
