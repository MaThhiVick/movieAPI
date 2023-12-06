//
//  URLMovies.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 04/12/23.
//

enum URLMoviesType {
    case detail(Int)
    case image(String)
    case list(MovieListPath)

    var stringName: String {
        switch self {
        case .detail(_):
            "movieDetail"
        case .image(_):
            "movieImage"
        default:
            "movieList"
        }
    }
}

enum MovieListPath: String, CaseIterable {
    case upcoming
    case topRated = "top_rated"
    case popular
}
