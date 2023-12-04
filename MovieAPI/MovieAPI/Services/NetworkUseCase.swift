//
//  NetworkUseCase.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 04/12/23.
//

import Foundation
import NetworkService

protocol NetworkRequestUseCase {
    func request(urlMovie: URLMovies) async -> Data?
}

class NetworkUseCase: NetworkRequestUseCase {
    let urlProvider: URLProvider
    let networkService: NetworkRequest

    init(urlProvider: URLProvider = DefaultURLProvider()) {
        self.urlProvider = urlProvider
        self.networkService = NetworkService(headers: urlProvider.getNetworkHeaders())
    }

    func request(urlMovie: URLMovies) async -> Data? {
        var data: Data?
        do {
            guard let url = urlProvider.getURLMovie(from: urlMovie) else {
                return nil
            }
            data = try await self.networkService.request(url: url, httpMethod: .get)
        } catch {
            return nil
        }
        return data
    }
}
