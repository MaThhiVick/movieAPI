//
//  ContentView.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import SwiftUI

struct MovieListView: View {
    let viewModel: MovieListViewModel
    @State var movieList = [Movie]()
    @State private var index = 0
    private let frameHeight: CGFloat = 500

    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    TabView(selection: $index) {
                        ForEach(movieList, id: \.self) { movie in
                            MovieCard(image: UIImage().dataConvert(data: movie.imageData), cardSize: .big)
                        }
                    }
                    .frame(height: frameHeight)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                    Carousel(items: $movieList, title: "Top Rated") { movie in
                        MovieCard(image: UIImage().dataConvert(data: movie.imageData), cardSize: .small)
                    }
                    .padding(.top, 36)

                    Carousel(items: $movieList, title: "Popular") { movie in
                        MovieCard(image: UIImage().dataConvert(data: movie.imageData), cardSize: .small)
                    }
                    .padding(.top, 36)
                }
            }
            .navigationTitle("Up coming")
        }
        .onAppear(perform: {
            Task {
                do {
                    movieList = try await viewModel.getMovieList()
                } catch {
                    print(error)
                }
            }
        })
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel())
}
