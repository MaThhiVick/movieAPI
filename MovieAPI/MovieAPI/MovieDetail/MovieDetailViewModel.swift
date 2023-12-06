//
//  MovieDetailViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import Foundation
import NetworkService

final class MovieDetailViewModel {
    let networkService: NetworkRequestUseCase

    init(networkService: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkService = networkService
    }

    func getMovieDetail(from movieId: Int) async -> MovieDetailModel? {
        let data: MovieDetailModel? = await networkService.request(urlMovie: .detail(movieId))
        return data
    }
}
