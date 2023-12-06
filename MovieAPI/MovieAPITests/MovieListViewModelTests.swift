//
//  MovieListViewModelTests.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 03/12/23.
//

import XCTest
@testable import MovieAPI

final class MovieListViewModelTests: XCTestCase {
    var sut: MovieListViewModel!
    var networkService: MockNetworkUseCase!

    override func setUpWithError() throws {
        networkService = MockNetworkUseCase()
        sut = MovieListViewModel(networkService: networkService)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkService = nil
    }

    func testGetMovie_successfulReturnFromNetwork_shouldReturnMovieResponse() {
        Task {
            await sut.getMovies()
            XCTAssertEqual(sut.upcomingList, MovieResponseModel.getMovieResponse().results)
            XCTAssertFalse(sut.isLoading)
        }
    }

    func testGetMovie_receiveNilFromNetwork_shouldReturnNil() {
        networkService.shouldReturnNil = true
        Task {
            await sut.getMovies()
        }
        XCTAssertTrue(sut.upcomingList.isEmpty)
    }
}
