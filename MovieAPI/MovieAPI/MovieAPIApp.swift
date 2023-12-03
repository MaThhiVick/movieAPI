//
//  MovieAPIApp.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import SwiftUI

@main
struct MovieAPIApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieListViewModel())
        }
    }
}
