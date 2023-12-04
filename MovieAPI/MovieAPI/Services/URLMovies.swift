//
//  URLMovies.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 04/12/23.
//

enum URLMovies {
    case detail(Int)
    case image(String)
    case list

    var stringName: String {
        switch self {
        case .detail(_):
            "movieDetail"
        case .image(_):
            "movieImage"
        case .list:
            "movieList"
        }
    }
}
