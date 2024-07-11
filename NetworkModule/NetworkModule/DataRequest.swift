//
//  DataRequest.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol DataRequest {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [String: String] { get }
}

public extension DataRequest {
    var headers: [String: String] {
        [:]
    }
    var queryItems: [String: String]{
        [:]
    }
    
    var method: HTTPMethod {
        .get
    }
}
