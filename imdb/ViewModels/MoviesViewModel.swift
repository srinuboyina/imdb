//
//  MoviesViewModel.swift
//  imdb
//
//  Created by apple on 19/10/22.
//

import Foundation



protocol MoviesDelegate: AnyObject {
    func moviesLoaded()
}

class MoviesViewModel {
    var movies: [Movie] = []
    weak var delegate: MoviesDelegate?
    func getMovies() {
        if let path = Bundle.main.path(forResource: "movies", ofType: "json"){
            let url = URL(fileURLWithPath: path)
            do {
                let data = try! Data(contentsOf: url)
                let responseModel = try JSONDecoder().decode([Movie].self, from: data)
                self.movies = responseModel
                SharedMovies.shared.movies = responseModel
                self.delegate?.moviesLoaded()
            } catch let jsonErr {
                print("Failed to serialize json:", jsonErr)
            }
        }
    }
}
