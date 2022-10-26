//
//  MoviesViewModelTests.swift
//  imdbTests
//
//  Created by apple on 26/10/22.
//

import XCTest
@testable import imdb

class MoviesDelegateStub: MoviesDelegate {
    var moviesLoadedCalled = false
    func moviesLoaded() {
        moviesLoadedCalled = true
    }
}

final class MoviesViewModelTests: XCTestCase {
    
    let viewModel = MoviesViewModel()
    let delegate = MoviesDelegateStub()
    
    override func setUp() {
        viewModel.delegate = delegate
        viewModel.getMovies()
    }
    
    func testMovies() {
        XCTAssert(SharedMovies.shared.movies.count > 1)
        XCTAssert(delegate.moviesLoadedCalled == true)
    }

}

