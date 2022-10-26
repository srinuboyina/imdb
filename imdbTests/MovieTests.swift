//
//  MovieTests.swift
//  imdbTests
//
//  Created by apple on 26/10/22.
//

import XCTest
@testable import imdb

final class MovieTests: XCTestCase {

    var movie: Movie!
    
    override func setUp() {
        let director = Director(name: "Test Director", pictureUrl: "testurl")
        let actor = Actor(name: "test actorr", pictureUrl: "pictureUrl", character: "character")
        movie = Movie(rating: 3, id: 1234, releaseDate: "2020-02-02", director: director, posterUrl: "testPosterURL", cast: [actor], runtime: 131, title: "test movie", overview: "overview", reviews: 4, budget: 5400000, language: "en-US", genres: ["Action", "Drama"])
    }
    
    func testYear() {
        XCTAssert(movie.date == "02.02.2020")
        XCTAssert(movie.year == "(2020)")
    }
    
    func testGenres() {
        XCTAssert(movie.genres.count == 2)
    }
    
    func testTime() {
        XCTAssert(movie.time == "2h 11m")
    }
    
    func testDateTime() {
        XCTAssert(movie.dateAndTime == "02.02.2020  .  2h 11m")
    }

}

