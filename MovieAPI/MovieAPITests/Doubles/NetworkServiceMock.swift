//
//  NetworkServiceMock.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 06/12/23.
//

import Foundation
@testable import MovieAPI
import NetworkService

final class NetworkServiceMock: NetworkRequest {
    var dataToReturn: Encodable = "test"
    var shouldThrowsError = false

    init(headers: [String: String] = ["": ""], urlSession: URLSession = URLSession.shared) {

    }

    func request(url: URL, httpMethod: HTTPMethod) async throws -> Data {
        if shouldThrowsError {
            throw NSError()
        }

        return try JSONEncoder().encode(dataToReturn)
    }
}
