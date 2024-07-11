//
//  ListMovieViewModel.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import Foundation
import Combine
import UIKit
import Domain

final class ListMovieViewModel {
    
    let useCase: MovieUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var listMovies: [ListMovieResult] = []
    @Published var searchResults: [ListMovieResult] = []
    
    var pagination = 1
    
    init(useCase: MovieUseCaseProtocol = MovieUseCase()){
        self.useCase = useCase
    }
}

// fetch Movie
extension ListMovieViewModel {
    // list menu movie
    func fetchListMovie(page: Int = 1) {
        self.useCase.listMovie(page: String(page)).sink(receiveCompletion: { result in
            // handling for error case and finished load data from api
        }, receiveValue: { [unowned self] listMovie in
            if let listMovie = listMovie?.results {
                if page == 1 {
                    self.listMovies = listMovie
                } else {
                    self.listMovies.append(contentsOf: listMovie)
                }
            }
        }).store(in: &cancellables)
    }
}

// reload and pagination
extension ListMovieViewModel {
    // pagination movie
    func paginationListMovie(){
        pagination += 1
        self.fetchListMovie(page: pagination)
    }
    
    // refresh list
    func refreshListMovie(){
        pagination = 1
        self.fetchListMovie(page: pagination)
    }
}

// search movie
extension ListMovieViewModel {
    func setupSearchMovie(searchField: UITextField){
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: searchField)
            .compactMap { ($0.object as? UITextField)?.text }
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.searchMovie(search: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func searchMovie(search: String) {
        self.useCase.searchMovie(search: search).sink(receiveCompletion: { result in
            // handling for error case and finished load data from api
        }, receiveValue: { [unowned self] movie in
            if let movie = movie?.results {
                self.searchResults = movie
            }
        }).store(in: &cancellables)
    }
    
    func getGenre(){
        self.useCase.getGenre().sink(receiveCompletion: {
            result in
        }, receiveValue: { genre in
            if let genre = genre?.genres {
                genreList = genre
            }
        }).store(in: &cancellables)
    }
}
