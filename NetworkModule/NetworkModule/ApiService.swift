//
//  ApiService.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation

public protocol NetworkServicesProtocol {
    func request<Response: Codable>(_ request: DataRequest, responseType: Response.Type, completion: @escaping (Result<Response, Error>) -> Void)
}

public class DefaultNetworkServices: NetworkServicesProtocol {
    public init() {}
    public func request<Response: Codable>(_ request: DataRequest, responseType: Response.Type, completion: @escaping (Result<Response, Error>) -> Void) {
        
        guard var urlComponent = URLComponents(string: request.url) else {
            let error = NSError(domain: ErrorResponse.invalidEndpoint.rawValue, code: 404, userInfo: nil)
            return completion(.failure(error))
        }
        
        var queryItems: [URLQueryItem] = []
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else {
            let error = NSError(domain: ErrorResponse.invalidEndpoint.rawValue, code: 404, userInfo: nil)
            return completion(.failure(error))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(NSError()))
            }
            do {
                
                let decoder = JSONDecoder()
                let responseModel = try decoder.decode(Response.self, from: data)
                completion(.success(responseModel))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
