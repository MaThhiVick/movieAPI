//
//  DataResponseMock.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 03/12/23.
//

import Foundation
@testable import MovieAPI

let mockMovie = Movie(
    adult: false,
    backdropPath: "/xgGGinKRL8xeRkaAR9RMbtyk60y.jpg",
    genreIDs: [16, 10751, 10402, 14, 35],
    id: 901362,
    originalLanguage: "en",
    originalTitle: "Trolls Band Together",
    overview: "When Branch’s brother, Floyd, is kidnapped for his musical talents by a pair of nefarious pop-star villains, Branch and Poppy embark on a harrowing and emotional journey to reunite the other brothers and rescue Floyd from a fate even worse than pop-culture obscurity.",
    popularity: 1319.467,
    posterPath: "/bkpPTZUdq31UGDovmszsg2CchiI.jpg",
    releaseDate: "2023-10-12",
    title: "Trolls Band Together",
    video: false,
    voteAverage: 7.226,
    voteCount: 246,
    imageData: nil
)

let mockMovieResponse = MovieResponse(
    dates: Dates(maximum: "2023-12-27", minimum: "2023-12-06"),
    page: 1,
    results: [mockMovie],
    totalPages: 37,
    totalResults: 721
)
