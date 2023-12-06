//
//  MovieListViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import Foundation

final class MovieListViewModel: ObservableObject {
    let networkService: NetworkRequestUseCase
    @Published var upcomingList = [Movie]()
    @Published var topRatedList = [Movie]()
    @Published var popularList = [Movie]()
    @Published var isLoading = true

    init(networkService: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkService = networkService
    }

    @MainActor
    func getMovies() async {
        Task {
            upcomingList = await getMovie(.list(.upcoming))
            topRatedList = await getMovie(.list(.topRated))
            popularList = await getMovie(.list(.popular))
            isLoading = false
        }
    }

    private func getMovie(_ urlMovie: URLMoviesType) async -> [Movie] {
        guard let movieResponse: MovieResponseModel = await networkService.request(urlMovie: urlMovie) else {
            return []
        }

        let result = await insertImageData(movieResponse: movieResponse).results
        return result
    }

    private func insertImageData(movieResponse: MovieResponseModel) async -> MovieResponseModel {
        var result = movieResponse
        for i in 0..<result.results.count {
            result.results[i].imageData = await networkService.request(urlMovie: .image(result.results[i].posterPath))
        }
        return result
    }
}
