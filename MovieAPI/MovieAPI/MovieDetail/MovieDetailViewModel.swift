//
//  MovieDetailViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import Foundation

final class MovieDetailViewModel: ObservableObject {
    let networkService: NetworkRequestUseCase
    let movieInformation: Movie
    @Published var movieDetail: MovieDetailModel?
    @Published var isLoading = true

    init(networkService: NetworkRequestUseCase = NetworkUseCase(),
        movieInformation: Movie) {
        self.networkService = networkService
        self.movieInformation = movieInformation
    }

    @MainActor
    func getMovieDetail() async {
        guard let result: MovieDetailModel = await networkService.request(urlMovie: .detail(movieInformation.id)) else {
            return
        }
        movieDetail = result
        isLoading.toggle()
    }
}
