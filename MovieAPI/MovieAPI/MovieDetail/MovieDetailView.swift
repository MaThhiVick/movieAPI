//
//  MovieDetail.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import SwiftUI

struct MovieDetailView: View {
    let movieInformation: Movie
    let movieDetailViewModel: MovieDetailViewModel
    @State var movieDetail: MovieDetail?
    @State var loading = true

    init(movieInformation: Movie, viewModel: MovieDetailViewModel) {
        self.movieInformation = movieInformation
        self.movieDetailViewModel = viewModel
    }

    var body: some View {
        if loading == true {
            Text("loading")
                .onAppear {
                    // passar para a view model
                    Task {
                        guard let result = await movieDetailViewModel.getMovieDetail(movieId: movieInformation.id) else {
                            return
                        }
                        movieDetail = result
                        loading = false
                    }
                }
        } else {
            ScrollView( .vertical) {
                VStack(alignment: .leading, spacing: .none) {
                    MovieCard(image: UIImage().dataConvert(data: movieInformation.imageData), cardSize: .big)
                        .frame(height: 600)
                        .ignoresSafeArea(edges: .top)

                    VStack(alignment: .leading, spacing: .none) {
                        Text(movieDetail?.originalTitle ?? "")
                            .font(.title)
                            .padding(.top, 8)

                        Text("\(movieDetail?.runtime ?? 1)min")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 12)

                        informationSection()
                    }
                    .padding(.leading, 8)
                }
            }
        }
    }

    @ViewBuilder
    func informationSection() -> some View {
        InformationMovieCard(title: "Overview", information: movieDetail?.overview ?? "")
        InformationMovieCard(title: "Release date", information: movieDetail?.releaseDate ?? "Not informed yet")
        InformationMovieCard(title: "Average", information: "\(movieDetail?.voteAverage ?? 0)")
        InformationMovieCard(title: "Budget", information: "\(movieDetail?.budget ?? 0)")
        InformationMovieCard(title: "Popularity", information: "\(movieDetail?.popularity ?? 0)")
    }
}

#Preview {
    MovieDetailView(movieInformation: Movie(adult: false, backdropPath: "test", genreIDs: [], id: 1, originalLanguage: "en", originalTitle: "test movie", overview: "test test test test test test", popularity: 1, posterPath: "test", releaseDate: "test", title: "test", video: false, voteAverage: 1, voteCount: 1, imageData: nil), viewModel: MovieDetailViewModel())
}
