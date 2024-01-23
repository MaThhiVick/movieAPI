//
//  ContentView.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListViewModel
    @State private var index = 0
    private let frameHeight: CGFloat = 500

    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    upcomingMovieSection()
                    carouselSection()
                }
            }
            .navigationTitle("")
        }
        .redacted(reason: $viewModel.isLoading.wrappedValue == true ? .placeholder : [])
        .onAppear(perform: {
            Task {
                await viewModel.getAllListMovies()
            }
        })
    }

    @ViewBuilder
    func upcomingMovieSection() -> some View {
        VStack(alignment: .leading, spacing: .none) {
            Text("Upcoming")
                .font(.largeTitle)
                .bold()
                .padding(.top, 32)
                .padding(.leading, 8)
            TabView(selection: $index) {
                ForEach(viewModel.upcomingList, id: \.self) { movie in
                    NavigationLink(destination: MovieDetailView(movieInformation: movie)) {
                        MovieCard(image: UIImage().dataConvert(data: movie.imageData), cardSize: .big)
                    }
                }
            }
            .padding(.top, -12)
            .frame(height: frameHeight)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }

    @ViewBuilder
    func carouselSection() -> some View {
        Carousel(items: $viewModel.topRatedList, title: "Top Rated") { movie in
            NavigationLink(destination: MovieDetailView(movieInformation: movie)) {
                MovieCard(image: UIImage().dataConvert(data: movie.imageData), cardSize: .small)
            }
        }
        .padding(.top, 32)

        Carousel(items: $viewModel.popularList, title: "Popular") { movie in
            NavigationLink(destination: MovieDetailView(movieInformation: movie)) {
                MovieCard(image: UIImage().dataConvert(data: movie.imageData), cardSize: .small)
            }
        }
        .padding(.top, 32)
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel())
}
