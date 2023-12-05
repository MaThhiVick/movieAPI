//
//  ContentView.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import SwiftUI

struct MovieListView: View {
    let viewModel: MovieListViewModel
    @State var upcomingList = [Movie]()
    @State var topRatedList = [Movie]()
    @State var popularList = [Movie]()
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
            .navigationTitle("Up coming")
        }
        .onAppear(perform: {
            Task {
                if let result: MovieResponseModel = await viewModel.getMovie(.list(.upcoming)) {
                    upcomingList = result.results
                }
                if let resultt: MovieResponseModel = await viewModel.getMovie(.list(.popular)) {
                    popularList = resultt.results
                }
                if let resulttt: MovieResponseModel = await viewModel.getMovie(.list(.topRated)) {
                    topRatedList = resulttt.results
                }

            }
        })
    }

    @ViewBuilder
    func upcomingMovieSection() -> some View {
        TabView(selection: $index) {
            ForEach(upcomingList, id: \.self) { movie in
                NavigationLink(destination: MovieDetailView(movieInformation: movie, viewModel: MovieDetailViewModel())) {
                    MovieCard(image: UIImage().dataConvert(data: movie.imageData), cardSize: .big)
                }
            }
        }
        .frame(height: frameHeight)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    @ViewBuilder
    func carouselSection() -> some View {
        Carousel(items: $topRatedList, title: "Top Rated") { movie in
            MovieCard(image: UIImage().dataConvert(data: movie.imageData), cardSize: .small)
        }
        .padding(.top, 32)

        Carousel(items: $popularList, title: "Popular") { movie in
            MovieCard(image: UIImage().dataConvert(data: movie.imageData), cardSize: .small)
        }
        .padding(.top, 32)
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel())
}
