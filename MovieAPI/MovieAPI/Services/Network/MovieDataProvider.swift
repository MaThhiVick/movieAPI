//
//  NetworkService.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 13/12/23.
//

import Foundation

protocol MovieDataProviderProtocol {
    func getMovies(from urlMovie: URLMoviesType) async -> [Movie]
}

class MovieDataProvider: MovieDataProviderProtocol {
    let networkRequest: NetworkRequestUseCase

    init(networkRequest: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkRequest = networkRequest
    }

    func getMovies(from urlMovie: URLMoviesType) async -> [Movie] {
        guard let movieResponse: MovieResponseModel = await networkRequest.request(urlMovie: urlMovie) else {
            return []
        }

        let result = await insertImageData(movieResponse: movieResponse).results
        return result
    }

    private func insertImageData(movieResponse: MovieResponseModel) async -> MovieResponseModel {
        var result = movieResponse
        for i in 0..<result.results.count {
            result.results[i].imageData = await networkRequest.request(urlMovie: .image(result.results[i].posterPath))
        }
        return result
    }
}
