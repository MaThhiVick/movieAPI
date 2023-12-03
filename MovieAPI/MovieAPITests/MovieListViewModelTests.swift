//
//  MovieListViewModelTests.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 03/12/23.
//

import XCTest
@testable import MovieAPI

final class MovieListViewModelTests: XCTestCase {
    var movieListViewModel: MovieListViewModel!

    override func setUpWithError() throws {
        movieListViewModel = MovieListViewModel(networkService: NetworkServiceMock())
    }

    override func tearDownWithError() throws {
        movieListViewModel = nil
    }

    func testGetMovieList_successfulRequest_ReturnMovieList() async throws {
        let result = try await movieListViewModel.getMovieList()
        XCTAssertEqual(result, mockMovieResponse.results)
    }
}
