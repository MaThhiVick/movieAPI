//
//  MovieAPITests.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 02/12/23.
//

import XCTest
@testable import MovieAPI

class NetworkServiceTests: XCTestCase {
    var networkService: NetworkService!
    let apiURL = URL(string: "https://jsonplaceholder.typicode.com/posts/42")!

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        networkService = NetworkService(urlSession: urlSession)
    }

    override func tearDown() {
        networkService = nil
    }

    func testGetMovieList_whenSuccessfulRequest_resultShouldBeEqualToMock() async throws {
        let jsonData = try JSONEncoder().encode(mockMovieResponse)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, jsonData)
        }

        let result = try await networkService.getMovieList()

        XCTAssertEqual(result, mockMovieResponse.results, "result should be equail to mockMovieResponse")
      }

    func testGetMovieList_whenDataIsNil_shouldReturnError() async {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }

        do {
            let result = try await networkService.getMovieList()
            XCTFail("Should fail")
        } catch {
            XCTAssertEqual(error as! NetworkErrors, NetworkErrors.networkError)
        }
    }

    func testDownloadimage_whenSuccessfulRequest_shouldReturnData() async throws {
        let data = "teste"
        let jsonData = try JSONEncoder().encode(data)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, jsonData)
        }

        let result = try await networkService.downloadImage(moviePath: data)

        XCTAssertEqual(result, jsonData, "Result should be equal to jsonData")
    }
}
