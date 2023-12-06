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

    init(headers: [String: String] = ["": ""], urlSession: URLSession = URLSession.shared) { }

    func request(url: URL, httpMethod: HTTPMethod) async throws -> Data {
        return try JSONEncoder().encode(dataToReturn)
    }
}
