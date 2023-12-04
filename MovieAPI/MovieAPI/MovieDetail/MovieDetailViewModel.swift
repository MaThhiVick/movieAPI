//
//  MovieDetailViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import Foundation
import NetworkService

class MovieDetailViewModel {
    let networkService: NetworkRequestUseCase

    init(networkService: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkService = networkService
    }

    func getMovieDetail(from movieId: Int) async -> MovieDetailModel? {
        guard let data = await networkService.request(urlMovie: .detail(movieId)) else {
            return nil
        }

        do {
           return try JSONDecoder().decode(MovieDetailModel.self, from: data)
        } catch {
            return nil
        }
    }
}
