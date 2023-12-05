//
//  URLProvider.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 04/12/23.
//

import Foundation

protocol URLProvider {
    func getURLMovie(from urlType: URLMoviesType) -> URL?
    func getNetworkHeaders() -> [String: String]
}

class DefaultURLProvider: URLProvider {
    func getNetworkHeaders() -> [String: String] {
        guard let header = Bundle.main.object(forInfoDictionaryKey: "MovieHeader") as? Dictionary<String, String> else {
            return ["": ""]
        }
        return header
    }

    func getURLMovie(from urlType: URLMoviesType) -> URL? {
        if let defaultUrl = getDefaultURL(fromMovie: urlType) {
            switch urlType {
            case .detail(let id):
                return insert(movieId: id, to: defaultUrl)
            case .image(let path):
                return defaultUrl.appendingPathComponent(path)
            case .list(let path):
                return defineMovieList(from: path, to: defaultUrl)
            }
        }
        return nil
    }

    private func defineMovieList(from path: MovieListPath, to url: URL) -> URL? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }

        let newPath = url.path.replacingOccurrences(of: "TYPE", with: "\(path.rawValue)")
        components.path = newPath

        return components.url
    }

    private func insert(movieId: Int, to url: URL) -> URL? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }

        let newPath = url.path.replacingOccurrences(of: "MOVIE_ID", with: "\(movieId)")
        components.path = newPath

        return components.url
    }

    private func getDefaultURL(fromMovie urlType: URLMoviesType) -> URL? {
        guard let urlBundle = Bundle.main.object(forInfoDictionaryKey: "URLMovies") as? Dictionary<String, String> else {
            return nil
        }

        for (key, value) in urlBundle {
            if key == urlType.stringName {
                return URL(string: value)
            }
        }
        return nil
    }
}
