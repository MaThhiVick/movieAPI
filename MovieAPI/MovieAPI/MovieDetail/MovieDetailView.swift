//
//  MovieDetail.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel

    init(movieInformation: Movie) {
        self.viewModel = MovieDetailViewModel(movieInformation: movieInformation)
    }

    var body: some View {
        ScrollView( .vertical) {
            VStack(alignment: .leading, spacing: .none) {
                MovieCard(image: UIImage().dataConvert(data: viewModel.movieInformation.imageData), cardSize: .big)
                    .frame(height: 600)
                    .ignoresSafeArea(edges: .top)

                VStack(alignment: .leading, spacing: .none) {
                    Text(viewModel.movieDetail?.originalTitle ?? "")
                        .font(.title)
                        .padding(.top, 8)

                    Text("\(viewModel.movieDetail?.runtime ?? 1)min")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 12)

                    informationSection()
                }
                .padding(.leading, 8)
            }
        } 
        .redacted(reason: $viewModel.isLoading.wrappedValue == true ? .placeholder : [])
        .onAppear {
            Task {
                await viewModel.getMovieDetail()
            }
        }
    }

    @ViewBuilder
    func informationSection() -> some View {
        InformationMovieCard(title: "Overview", information: viewModel.movieDetail?.overview ?? "")
        InformationMovieCard(title: "Release date", information: viewModel.movieDetail?.releaseDate ?? "Not informed yet")
        InformationMovieCard(title: "Average", information: "\(viewModel.movieDetail?.voteAverage ?? 0)")
        InformationMovieCard(title: "Budget", information: "\(viewModel.movieDetail?.budget ?? 0)")
        InformationMovieCard(title: "Popularity", information: "\(viewModel.movieDetail?.popularity ?? 0)")
    }
}

#Preview {
    MovieDetailView(movieInformation: Movie(adult: false, backdropPath: "test", genreIDs: [], id: 1, originalLanguage: "en", originalTitle: "test movie", overview: "test test test test test test", popularity: 1, posterPath: "test", releaseDate: "test", title: "test", video: false, voteAverage: 1, voteCount: 1, imageData: nil))
}
