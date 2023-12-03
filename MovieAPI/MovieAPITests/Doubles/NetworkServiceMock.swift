//
//  NetworkServiceMock.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 03/12/23.
//

import Foundation
@testable import MovieAPI

class NetworkServiceMock: NetworkRequest {
    func getMovieList() async throws -> [Movie] {
        mockMovieResponse.results
    }
    
    func downloadImage(moviePath: String) async throws -> Data {
        return Data()
    }
}

