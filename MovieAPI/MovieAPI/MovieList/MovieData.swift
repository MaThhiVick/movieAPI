//
//  MovieData.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 02/12/23.
//

import Foundation
import SwiftUI

class MovieData: ObservableObject {
    @Published var upcomingMovies = [Movie]()
    @Published var topRatedMovies = [Movie]()
    @Published var popularMovies = [Movie]()
}
