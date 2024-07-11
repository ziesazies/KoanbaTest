//
//  MovieCellView.swift
//  Movie
//
//  Created by Phincon on 10/07/24.
//

import Foundation
import UIKit
import Domain

class MovieCellView: UIView {
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var releaseDateLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    lazy var genreLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .lightGray
        return label
    }()
    
    lazy var movieImg: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 5
        image.backgroundColor = .lightGray
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
        setupConstraint()
    }
    
    private func setupLayout(){
        [titleLbl, releaseDateLbl, genreLbl, movieImg].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraint(){
        // movie Img constraint
        NSLayoutConstraint.activate([
            movieImg.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            movieImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieImg.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            movieImg.heightAnchor.constraint(equalToConstant: 100),
            movieImg.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // title constraint
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLbl.leadingAnchor.constraint(equalTo: movieImg.trailingAnchor, constant: 5),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        // release constraint
        NSLayoutConstraint.activate([
            releaseDateLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor),
            releaseDateLbl.leadingAnchor.constraint(equalTo: movieImg.trailingAnchor, constant: 5),
            releaseDateLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        // genre constraint
        NSLayoutConstraint.activate([
            genreLbl.leadingAnchor.constraint(equalTo: movieImg.trailingAnchor, constant: 5),
            genreLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            genreLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setupContent(movie: ListMovieResult){
        titleLbl.text = movie.title
        genreLbl.text = movie.getGenre()
        releaseDateLbl.text = movie.release_date
        movieImg.downloaded(from: Constant.baseUrlImg + (movie.poster_path ?? ""))
    }
}
