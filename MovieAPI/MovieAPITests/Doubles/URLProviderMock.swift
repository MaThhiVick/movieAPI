//
//  URLProviderMock.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 06/12/23.
//

import Foundation
@testable import MovieAPI

final class URLProviderMock: URLProvider {
    var shouldReturnNil = false

    func getURLMovie(from urlType: MovieAPI.URLMoviesType) -> URL? {
        if shouldReturnNil {
            return nil
        }
        return URL(string: "testURL")
    }

    func getNetworkHeaders() -> [String: String] {
        ["test": "test"]
    }
}
