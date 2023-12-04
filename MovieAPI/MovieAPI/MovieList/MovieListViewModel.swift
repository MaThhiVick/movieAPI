//
//  MovieListViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import Foundation

class MovieListViewModel {
    let networkService: NetworkRequest

    init(networkService: NetworkRequest = NetworkService()) {
        self.networkService = networkService
    }

    func getMovieList() async throws -> [Movie] {
        let result = try await networkService.getMovieList()
        return await insertImageData(movieList: result)
    }

    private func insertImageData(movieList: [Movie]) async -> [Movie] {
        var movieList = movieList
        for i in 0..<movieList.count {
            do {
                movieList[i].imageData = try await networkService.downloadImage(moviePath: movieList[i].posterPath)
            } catch {
                movieList[i].imageData = nil
            }
        }
        return movieList
    }

    func getMovieDetail(movieId: Int) async -> MovieDetail? {
        do {
           return try await networkService.getMovieDetail(movieId: movieId)
        } catch {
            return nil
        }
    }
}
