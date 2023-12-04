//
//  NetworkService.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import Foundation

protocol NetworkRequest {
    func getMovieList() async throws -> [Movie]
    func downloadImage(moviePath: String) async throws -> Data
    func getMovieDetail(movieId: Int) async throws -> MovieDetail
}

final class NetworkService: NetworkRequest {
    private let movieListURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1")!
    private let imageBaseURL = URL(string: "http://image.tmdb.org/t/p/w500/")!
    private let httpMethod = "GET"
    let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func getMovieList() async throws -> [Movie] {
        var result = [Movie]()

        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGI4ODk2ODBkODI1ZmI2MGZlYmFjYTk1NjgxYTkxZCIsInN1YiI6IjY1NmFkYWRhZmNhZGI0MDBhZGQzNjlhMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.d-OSE-4XS7pdA33Xi7VdJzX_NiP2rqh-e8tFITQNYhA"
        ]
        
        var request = URLRequest(url: movieListURL)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            result = movieResponse.results
        } catch {
            throw NetworkErrors.networkError
        }
        
        return result
    }

    func getMovieDetail(movieId: Int) async throws -> MovieDetail {
        var result: MovieDetail
        let baseURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?language=en-US")!

        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGI4ODk2ODBkODI1ZmI2MGZlYmFjYTk1NjgxYTkxZCIsInN1YiI6IjY1NmFkYWRhZmNhZGI0MDBhZGQzNjlhMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.d-OSE-4XS7pdA33Xi7VdJzX_NiP2rqh-e8tFITQNYhA"
        ]

        var request = URLRequest(url: baseURL)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers

        do {
            let (data, _) = try await urlSession.data(for: request)
            result = try JSONDecoder().decode(MovieDetail.self, from: data)
        } catch {
            throw NetworkErrors.networkError
        }

        return result
    }

    func downloadImage(moviePath: String) async throws -> Data {
        let imageUrl = imageBaseURL.appendingPathComponent(moviePath)
        var request = URLRequest(url: imageUrl)
        request.httpMethod = httpMethod
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            return data
        } catch {
            throw NetworkErrors.imageDownloadError
        }
    }
}
