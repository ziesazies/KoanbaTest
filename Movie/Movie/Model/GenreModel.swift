//
//  GenreModel.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation

public var genreList: [Genres] = []

public struct GenreModel : Codable {
    public let genres : [Genres]?

    enum CodingKeys: String, CodingKey {

        case genres = "genres"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
    }
}

public struct Genres : Codable {
    public let id : Int?
    public let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
