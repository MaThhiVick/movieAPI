//
//  NetworkUseCase.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 04/12/23.
//

import Foundation
import NetworkService

protocol NetworkRequestUseCase {
    func request<T: Decodable>(urlMovie: URLMoviesType) async -> T?
}

final class NetworkUseCase: NetworkRequestUseCase {
    let urlProvider: URLProvider
    let networkService: NetworkRequest

    init(urlProvider: URLProvider = DefaultURLProvider(), networkService: NetworkRequest = NetworkService(headers: DefaultURLProvider().getNetworkHeaders())) {
        self.urlProvider = urlProvider
        self.networkService = networkService
    }

    func request<T: Decodable>(urlMovie: URLMoviesType) async -> T? {
        do {
            guard let url = urlProvider.getURLMovie(from: urlMovie) else {
                return nil
            }
            let data = try await self.networkService.request(url: url, httpMethod: .get)
            if T.self == Data.self {
                return data as? T
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
