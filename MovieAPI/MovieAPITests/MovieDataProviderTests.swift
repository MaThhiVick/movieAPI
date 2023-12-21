//
//  MovieListViewModelTests.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 03/12/23.
//

import XCTest
@testable import MovieAPI

final class MovieDataProviderTests: XCTestCase {
    var sut: MovieDataProvider!
    var networkService: MockNetworkUseCase!

    override func setUpWithError() throws {
        networkService = MockNetworkUseCase()
        sut = MovieDataProvider(networkRequest: networkService)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkService = nil
    }

    func testGetMovie_successfulReturnFromNetwork_shouldReturnMovieResponse() async {
        let result = await sut.getMovies(from: .list(.popular))
        XCTAssertEqual(result, MovieResponseModel.getMovieResponse().results)
    }

    func testGetMovie_receiveNilFromNetwork_shouldReturnNil() async {
        networkService.shouldReturnNil = true
        let result = await sut.getMovies(from:.list(.popular))
        XCTAssertTrue(result.isEmpty)
    }
}
