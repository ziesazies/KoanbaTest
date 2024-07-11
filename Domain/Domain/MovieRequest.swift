//
//  MovieRequest.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation
import NetworkModule

public struct Constant {
    public static let baseUrl = "https://api.themoviedb.org/3/"
    public static let baseUrlImg = "https://image.tmdb.org/t/p/w200"
}

public struct VideoGamesRequest: DataRequest {
    public var url: String
    public var method: HTTPMethod
    public var headers: [String: String]?
    public var queryItems: [String: String]?
}

public enum MovieRequestData: DataRequest {
    
    case searchMovie(text: String)
    case listMovie(page: String)
    
    public var url: String {
        switch self {
        case .searchMovie(_):
            return Constant.baseUrl + "search/movie"
        case .listMovie:
            return Constant.baseUrl + "movie/popular"
        }
    }
    
    public var queryItems: [String : String] {
        switch self {
        case .searchMovie(let text):
            return [
                "query": text,
                "include_adult": "false",
                "language": "en-US",
                "page": "1"
            ]
        case .listMovie(let page):
            return [
                "page": "\(page)"
            ]
        }
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var headers: [String : String] {
        let header = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTQ4ODZlMmVlOTE1ZmU0ZjA1N2M1NWI1NDJkYWIxNSIsInN1YiI6IjYwODIzMWMxNzc3NmYwMDAyOTkxNmNmNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pEtSB4xEnlNdn8KIy854vw-uRzAlHTQLihh6xTj-5AI"
        ]
        return header
    }
}
