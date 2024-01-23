//
//  MovieResponseModelMock.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 05/12/23.
//

import Foundation
@testable import MovieAPI

extension MovieResponseModel: Equatable {
    public static func == (lhs: MovieAPI.MovieResponseModel, rhs: MovieAPI.MovieResponseModel) -> Bool {
        return lhs.movies == rhs.movies 
    }

    static func getMovieResponse() -> MovieResponseModel {
        return MovieResponseModel(
            dates: Dates(maximum: "2023-12-31", minimum: "2023-01-01"),
            page: 1,
            movies: [
                Movie(
                    adult: false,
                    backdropPath: "/example_backdrop_path.jpg",
                    genreIDs: [12, 34, 56],
                    id: 123,
                    originalLanguage: "en",
                    originalTitle: "Example Movie",
                    overview: "This is an example movie",
                    popularity: 123.45,
                    posterPath: "/example_poster_path.jpg",
                    releaseDate: "2023-12-01",
                    title: "Example Movie",
                    video: false,
                    voteAverage: 7.8,
                    voteCount: 100,
                    imageData: nil
                )
            ],
            totalPages: 2,
            totalResults: 20
        )
    }
}
