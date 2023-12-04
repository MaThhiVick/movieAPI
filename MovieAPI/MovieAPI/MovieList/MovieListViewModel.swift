//
//  MovieListViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import Foundation

class MovieListViewModel: ObservableObject {
    let networkService: NetworkRequestUseCase

    init(networkService: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkService = networkService
    }

    func getMovie<T: Decodable>(_ urlMovie: URLMovies) async -> T? {
        guard let data = await networkService.request(urlMovie: urlMovie) else {
            return nil
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            if let decoded = decodedData as? MovieResponseModel {
                return await insertImageData(movieResponse: decoded) as? T
            }
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }

    private func insertImageData(movieResponse: MovieResponseModel) async -> MovieResponseModel {
        var result = movieResponse
        for i in 0..<result.results.count {
            result.results[i].imageData = await networkService.request(urlMovie: .image(result.results[i].posterPath))
        }
        return result
    }
}
