//
//  ListMovieDataSource.swift
//  Movie
//
//  Created by Phincon on 10/07/24.
//

import Foundation
import UIKit

final class ListMovieDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var viewModel: ListMovieViewModel
    weak var view: UIViewController?

    init(viewModel: ListMovieViewModel, view: UIViewController) {
        self.viewModel = viewModel
        self.view = view
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.isEmpty ? viewModel.listMovies.count : viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        let movie = viewModel.searchResults.isEmpty ? viewModel.listMovies[indexPath.row] : viewModel.searchResults[indexPath.row]
        cell.setupContent(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.searchResults.isEmpty ? viewModel.listMovies[indexPath.row] : viewModel.searchResults[indexPath.row]
        let vc = MovieDetailViewController()
        vc.movie = movie
        vc.modalPresentationStyle = .fullScreen
        view?.present(vc, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            viewModel.paginationListMovie()
        }
    }
}
