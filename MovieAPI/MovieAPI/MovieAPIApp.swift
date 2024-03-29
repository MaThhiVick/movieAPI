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
            if NSClassFromString("XCTestCase") != nil {
                EmptyView()
            } else {
                MovieListView(viewModel: MovieListViewModel())
            }
        }
    }
}
