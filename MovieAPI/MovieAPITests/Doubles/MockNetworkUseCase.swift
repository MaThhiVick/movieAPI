//
//  MockNetworkService.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 05/12/23.
//

import Foundation
@testable import MovieAPI

class MockNetworkUseCase: NetworkRequestUseCase {
    var shouldReturnNil = false

    func request<T>(urlMovie: MovieAPI.URLMoviesType) async -> T? where T: Decodable {
        if shouldReturnNil {
            return nil
        }

        if T.self == Data.self {
            return nil
        }

        return MovieResponseModel.getMovieResponse() as? T
    }
}
