//
//  MovieCell.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import UIKit
import Domain

final class MovieCell: UITableViewCell {
    
    lazy var movieView: MovieCellView = {
        let view = MovieCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static let identifier = "MovieCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupLayout(){
        contentView.addSubview(movieView)
    }
    
    private func setupConstraint(){
        NSLayoutConstraint.activate([
            movieView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupContent(movie: ListMovieResult){
        movieView.setupContent(movie: movie)
    }
}
