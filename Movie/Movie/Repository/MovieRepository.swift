//
//  MovieRepository.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation
import CoreData
import NetworkModule

public protocol MovieRepositoryProtocol {
    func searchMovie(text: String, completion: @escaping(MovieModel?, Error?) -> Void)
    func listMovie(page: String, completion: @escaping(MovieModel?, Error?) -> Void)
    func getGenre(completion: @escaping(GenreModel?, Error?) -> Void)
    func fetchMovieFromDataBase() -> MovieModel?
}

public final class MovieRepository: MovieRepositoryProtocol {
    
    public let network: NetworkServicesProtocol
    
    public init(networking: NetworkServicesProtocol = DefaultNetworkServices()) {
        self.network = networking
    }
    
    public func searchMovie(text: String, completion: @escaping(MovieModel?, Error?) -> Void) {
        let req = MovieRequestData.searchMovie(text: text)
        network.request(req, responseType: MovieModel.self) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    public func listMovie(page: String, completion: @escaping(MovieModel?, Error?) -> Void) {
        let req = MovieRequestData.listMovie(page: page)
        CoreDataHelper.shared.deleteAllEntities(entityName: "MovieDBModel")
        network.request(req, responseType: MovieModel.self) { [unowned self] result in
            switch result {
            case .success(let success):
                self.insertListToDB(list: success.results)
                completion(success, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    public func getGenre(completion: @escaping(GenreModel?, Error?) -> Void){
        loadLocalJSON { genre, error in
           completion(genre, error)
        }
    }
    
    private func loadLocalJSON(completion: @escaping (GenreModel?, Error?) -> Void) {
        guard let bundle = Bundle(identifier: "form.Domain") , let url = bundle.url(forResource: "genre", withExtension: "json") else {
            completion(nil, NSError(domain: "LocalJSONError", code: 404, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"]))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let genreModel = try decoder.decode(GenreModel.self, from: data)
            completion(genreModel, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    private func insertListToDB(list: [ListMovieResult]?){
        guard let movieList = list else { return }
        
        for movie in movieList {
            if let insertMovie = CoreDataHelper.shared.createEntity(entityName: "MovieDBModel") as? MovieDBModel {
                insertMovie.title = movie.title
                insertMovie.overview = movie.overview
                insertMovie.releaseDate = movie.release_date ?? ""
            }
        }
        
        CoreDataHelper.shared.saveContext()
    }
    
    public func fetchMovieFromDataBase() -> MovieModel? {
        return convertToMovieModel(from: retrieveAllMovie())
    }
    
    private func retrieveAllMovie() -> [MovieDBModel] {
        let fetchedEntities: [MovieDBModel] = CoreDataHelper.shared.fetchEntities(entityName: "MovieDBModel")
        return fetchedEntities
    }
    
    private func convertToMovieModel(from movies: [MovieDBModel]) -> MovieModel? {
        guard !movies.isEmpty else { return nil }
        let listMovieResults = movies.map { movie in
            ListMovieResult(
                original_title: movie.title,
                overview: movie.overview,
                release_date: movie.releaseDate,
                title: movie.title
            )
        }
        
        return MovieModel(results: listMovieResults)
    }
}
