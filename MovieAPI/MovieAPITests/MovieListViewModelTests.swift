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

    func testGetMovie_successfulReturnFromNetwork_shouldReturnMovieResponse() async {
        let movieResponse = await sut.getMovie(.list(.popular))

        XCTAssertEqual(movieResponse!, MovieResponseModel.getMovieResponse())
    }

    func testGetMovie_receiveNilFromNetwork_shouldReturnNil() async {
        networkService.shouldReturnNil = true
        let movieResponse = await sut.getMovie(.list(.popular))

        XCTAssertNil(movieResponse)
    }
}
