//
//  ListMovieResult.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation

public struct ListMovieResult : Codable {
    public let adult: Bool?
    public let backdrop_path: String?
    public let genre_ids: [Int]?
    public let id: Int?
    public let original_language: String?
    public let original_title: String?
    public let overview: String?
    public let popularity: Double?
    public let poster_path: String?
    public let release_date: String?
    public let title: String?
    public let video: Bool?
    public let vote_average: Double?
    public let vote_count: Int?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case genre_ids = "genre_ids"
        case id = "id"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case release_date = "release_date"
        case title = "title"
        case video = "video"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }

    public init(adult: Bool? = nil, backdrop_path: String? = nil, genre_ids: [Int]? = nil, id: Int? = nil, original_language: String? = nil, original_title: String? = nil, overview: String? = nil, popularity: Double? = nil, poster_path: String? = nil, release_date: String? = nil, title: String? = nil, video: Bool? = nil, vote_average: Double? = nil, vote_count: Int? = nil) {
          self.adult = adult
          self.backdrop_path = backdrop_path
          self.genre_ids = genre_ids
          self.id = id
          self.original_language = original_language
          self.original_title = original_title
          self.overview = overview
          self.popularity = popularity
          self.poster_path = poster_path
          self.release_date = release_date
          self.title = title
          self.video = video
          self.vote_average = vote_average
          self.vote_count = vote_count
      }
    
    public func getGenre() -> String {
        let genres = (genre_ids ?? []).compactMap { id in
            genreList.first { $0.id == id }?.name
        }
        return genres.joined(separator: ", ")
    }
}
