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

    init(networkService: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkService = networkService
    }

    @MainActor
    func getMovies() async {
        MovieListPath.allCases.forEach { path in
            switch path {
            case .upcoming:
                Task {
                    upcomingList = await getMovie(.list(.upcoming))
                }
            case .topRated:
                Task {
                    topRatedList = await getMovie(.list(.topRated))
                }
            case .popular:
                Task {
                    popularList = await getMovie(.list(.popular))
                }
            }
        }
    }

    private func getMovie(_ urlMovie: URLMoviesType) async -> [Movie] {
        guard let movieResponse: MovieResponseModel = await networkService.request(urlMovie: urlMovie) else {
            return []
        }

        return await insertImageData(movieResponse: movieResponse).results
    }

    private func insertImageData(movieResponse: MovieResponseModel) async -> MovieResponseModel {
        var result = movieResponse
        for i in 0..<result.results.count {
            result.results[i].imageData = await networkService.request(urlMovie: .image(result.results[i].posterPath))
        }
        return result
    }
}
