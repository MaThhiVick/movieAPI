//
//  MovieListViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import Foundation

final class MovieListViewModel: ObservableObject {
    let networkService: NetworkRequestUseCase

    init(networkService: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkService = networkService
    }

    func getMovie(_ urlMovie: URLMoviesType) async -> MovieResponseModel? {
        guard let movieResponse: MovieResponseModel = await networkService.request(urlMovie: urlMovie) else {
            return nil
        }

        return await insertImageData(movieResponse: movieResponse)
    }

    private func insertImageData(movieResponse: MovieResponseModel) async -> MovieResponseModel {
        var result = movieResponse
        for i in 0..<result.results.count {
            result.results[i].imageData = await networkService.request(urlMovie: .image(result.results[i].posterPath))
        }
        return result
    }
}
