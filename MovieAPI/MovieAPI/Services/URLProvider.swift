//
//  URLProvider.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 04/12/23.
//

import Foundation

protocol URLProvider {
    func getURLMovie(from urlMovie: URLMovies) -> URL?
    func getNetworkHeaders() -> [String: String]
}

class DefaultURLProvider: URLProvider {
    func getNetworkHeaders() -> [String: String] {
        guard let header = Bundle.main.object(forInfoDictionaryKey: "MovieHeader") as? Dictionary<String, String> else {
            return ["": ""]
        }
        return header
    }

    func getURLMovie(from urlMovie: URLMovies) -> URL? {
        if let defaultUrl = getDefaultURL(fromMovie: urlMovie) {
            switch urlMovie {
            case .detail(let id):
                return insert(movieId: id, to: defaultUrl)
            case .image(let path):
                return defaultUrl.appendingPathComponent(path)
            default:
                return defaultUrl
            }
        }
        return nil
    }

    private func insert(movieId: Int, to url: URL) -> URL? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }

        let newPath = url.path.replacingOccurrences(of: "MOVIE_ID", with: "\(movieId)")
        components.path = newPath

        return components.url
    }

    private func getDefaultURL(fromMovie urlMovie: URLMovies) -> URL? {
        guard let urlBundle = Bundle.main.object(forInfoDictionaryKey: "URLMovies") as? Dictionary<String, String> else {
            return nil
        }

        for (key, value) in urlBundle {
            if key == urlMovie.stringName {
                return URL(string: value)
            }
        }
        return nil
    }
}
