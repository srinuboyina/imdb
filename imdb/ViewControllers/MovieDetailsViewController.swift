//
//  MovieDetailsViewController.swift
//  imdb
//
//  Created by apple on 22/10/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movie: Movie!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        nameLabel.text = movie.title
        favouriteButton.setFavourite(favourite: movie.favourite)
        tableView.register(UINib(nibName: "MovieDetailsCell", bundle: nil), forCellReuseIdentifier: "MovieDetailsCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OverviewCell")
        tableView.register(UINib(nibName: "ActorsCell", bundle: nil), forCellReuseIdentifier: "ActorsCell")
        tableView.register(UINib(nibName: "DirectorCell", bundle: nil), forCellReuseIdentifier: "DirectorCell")
        tableView.register(UINib(nibName: "KeyFactsCell", bundle: nil), forCellReuseIdentifier: "KeyFactsCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    @IBAction func close() {
        self.dismiss(animated: true)
    }
    
    @IBAction func setFavourite() {
        movie.favourite = !(movie.favourite ?? false)
        let index = SharedMovies.shared.movies.firstIndex(where: { movie1 in
            return movie1.title == movie.title
        })
        if let index = index {
            SharedMovies.shared.movies[index].favourite = movie.favourite
        }
        favouriteButton.setFavourite(favourite: movie.favourite)
    }
}

extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section) {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsCell") as? MovieDetailsCell {
                cell.setMovie(movie: movie)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell") {
                cell.textLabel?.text = movie.overview
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.font = UIFont(name: "SFPro-Light", size: 16)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DirectorCell") as? DirectorCell {
                cell.setDirector(director: movie.director)
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ActorsCell") as? ActorsCell {
                cell.setMovie(movie: movie)
                return cell
            }
            
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "KeyFactsCell") as? KeyFactsCell {
                cell.setMovie(movie: movie)
                return cell
            }
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 0:
            return 475
        case 1:
            return 100
        case 2:
            return 170
        case 3:
            return 150.0  * CGFloat(movie.cast.count/3)
        case 4:
            return 177
        default:
            return 0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            nameLabel.isHidden = false
        } else {
            nameLabel.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var title = ""
        switch(section) {
        case 1:
            title = "Overview"
        case 2:
            title = "Director"
        case 3:
            title = "Actors"
        case 4:
            title = "Key Facts"
        default:
            break
            
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        let label1 = UILabel(frame: CGRect(x: 30, y: 0, width: 200, height: 20))
        label1.text = title
        label1.font = UIFont(name: "SFPro-Bold", size: 16)
        label1.textColor = .black
        view.addSubview(label1)
        view.backgroundColor = .white
        return view
    }
}
