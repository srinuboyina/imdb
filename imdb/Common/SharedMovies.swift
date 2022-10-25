//
//  SharedMovies.swift
//  imdb
//
//  Created by apple on 22/10/22.
//

import Foundation

class SharedMovies {
    var movies: [Movie] = []
    static let shared = SharedMovies()
    
    private init() {
        
    }
    
    var favourites: [Movie] {
        var favourites:[Movie] = []
        movies.forEach { movie in
            if movie.favourite ?? false {
                favourites.append(movie)
            }
        }
        return favourites
    }
}
