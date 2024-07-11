//
//  MovieRequest.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation
import NetworkModule

public struct Constant {
    public static let baseUrl = getBaseUrl().baseUrl
    public static let baseUrlImg = getBaseUrl().baseImg
    
    private static func getBaseUrl() -> (baseUrl: String, baseImg: String) {
        // Ensure the bundle identifier is correct
        guard let bundle = Bundle(identifier: "form.Domain") else {
            fatalError("Could not find the specified bundle.")
        }
        
        // Load the Domain.plist file from the specified bundle
        guard let path = bundle.path(forResource: "Domain", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path) else {
            fatalError("Could not find or load Domain.plist")
        }
        
        // Retrieve the values for APIBaseURL and imageBaseURL
        guard let apiBaseURL = plist["APIBaseURL"] as? String,
              let imageBaseURL = plist["imageBaseURL"] as? String else {
            fatalError("Could not find keys APIBaseURL or imageBaseURL in Domain.plist")
        }
        
        // Return the retrieved values
        return (apiBaseURL, imageBaseURL)
    }
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
