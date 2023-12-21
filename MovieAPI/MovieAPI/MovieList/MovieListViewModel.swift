//
//  MovieListViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import Foundation

final class MovieListViewModel: ObservableObject {
    let movieProvider: MovieDataProviderProtocol
    @Published var upcomingList = [Movie]()
    @Published var topRatedList = [Movie]()
    @Published var popularList = [Movie]()
    @Published var isLoading = true

    init(movieProvider: MovieDataProviderProtocol = MovieDataProvider()) {
        self.movieProvider = movieProvider
    }

    @MainActor
    func getAllListMovies() async {
        Task {
            upcomingList = await movieProvider.getMovies(from: .list(.upcoming))
            topRatedList = await movieProvider.getMovies(from: .list(.topRated))
            popularList = await movieProvider.getMovies(from: .list(.popular))
            isLoading = false
        }
    }
}
