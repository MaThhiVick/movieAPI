//
//  MovieDetailViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import Foundation

class MovieDetailViewModel {
    let networkService: NetworkRequest

    init(networkService: NetworkRequest = NetworkService()) {
        self.networkService = networkService
    }

    func getMovieDetail(movieId: Int) async -> MovieDetail? {
        do {
           return try await networkService.getMovieDetail(movieId: movieId)
        } catch {
            return nil
        }
    }
}
