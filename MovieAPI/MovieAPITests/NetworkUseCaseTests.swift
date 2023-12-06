//
//  NetworkUseCase.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 06/12/23.
//

import XCTest
@testable import MovieAPI
import NetworkService

final class NetworkUseCaseTests: XCTestCase {
    var sut: NetworkUseCase!
    var urlProvider: URLProviderMock!
    var networkService: NetworkServiceMock!

    override func setUpWithError() throws {
        urlProvider = URLProviderMock()
        networkService = NetworkServiceMock()
        sut = NetworkUseCase(urlProvider: urlProvider, networkService: networkService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequest_whenURLisNil_shouldReturnNil() async {
        urlProvider.shouldReturnNil = true

        if let _: String = await sut.request(urlMovie: .detail(0)) {
            XCTFail("should return nil")
            return
        }
    }

    func testRequest_networkRequestThrowError_shouldReturnNil() async {
        networkService.shouldThrowsError = true

        if let _: String = await sut.request(urlMovie: .detail(0)) {
            XCTFail("should return nil")
            return
        }
    }

    func testRequest_askForDataType_shouldReturnData() async {
        guard let data: Data = await sut.request(urlMovie: .detail(0)) else {
            XCTFail("should return some data")
            return
        }

        let decode = try! JSONDecoder().decode(String.self, from: data)
        XCTAssertEqual(decode, "test")
    }

    func testRequest_askForStringType_shouldReturnString() async {
        guard let data: String = await sut.request(urlMovie: .detail(0)) else {
            XCTFail("should return string")
            return
        }

        XCTAssertEqual(data, "test")
    }
}