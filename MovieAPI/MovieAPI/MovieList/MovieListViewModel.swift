//
//  MovieListViewModel.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import Foundation

class MovieListViewModel {
    let networkService: NetworkRequest = NetworkService()
    
    func getMovieList() async throws -> [Movie] {
        try await networkService.getMovieList()
    }
}
