//
//  MovieUseCase.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation
import Combine
import CoreData

public protocol MovieUseCaseProtocol {
    func searchMovie(search: String) -> Future<MovieModel?, Error>
    func listMovie(page: String) -> Future<MovieModel?, Error>
    func getGenre() -> Future<GenreModel?, Error>
}

public class MovieUseCase: MovieUseCaseProtocol {
    
    public let repo: MovieRepositoryProtocol
    
    public init(repo: MovieRepositoryProtocol = MovieRepository()) {
        self.repo = repo
    }
    
    public func searchMovie(search: String) -> Future<MovieModel?, Error> {
        Future { [unowned self] proxies in
            self.repo.searchMovie(text: search) { movie, error in
                if (error == nil) {
                    proxies(.success(movie))
                }
            }
        }
    }
    
    public func listMovie(page: String) -> Future<MovieModel?, Error> {
        Future { [unowned self] proxies in
            self.repo.listMovie(page: page) { movie, error in
                if (error == nil) {
                    proxies(.success(movie))
                } else {
                    // fetch from coredata
                    proxies(.success(self.repo.fetchMovieFromDataBase()))
                }
            }
        }
    }
    
    public func getGenre() -> Future<GenreModel?, Error> {
        Future { [unowned self] proxies in
            self.repo.getGenre { movie, error in
                if (error == nil) {
                    proxies(.success(movie))
                }
            }
        }
    }
}
