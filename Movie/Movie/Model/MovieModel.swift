//
//  ListMovie.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation

public struct MovieModel: Codable {
    public let page: Int?
    public let results: [ListMovieResult]
    public let total_pages: Int?
    public let total_results: Int?

    public init(page: Int? = nil, results: [ListMovieResult], total_pages: Int? = nil, total_results: Int? = nil) {
        self.page = page
        self.results = results
        self.total_pages = total_pages
        self.total_results = total_results
    }
}
