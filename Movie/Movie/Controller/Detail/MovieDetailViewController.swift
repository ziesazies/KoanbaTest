//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import UIKit
import Domain

final class MovieDetailViewController: UIViewController {
    
    private lazy var movieDetailView: MovieDetailView = {
        let view = MovieDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var movie: ListMovieResult?
    
    var castModel: [String] = ["Dave Franco", "Alexa Kee", "Fernando Abigael", "Dave Franco", "Alexa Kee", "Fernando Abigael", "Dave Franco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
        setupConstraint()
        
        guard let movie = movie else { return }
        movieDetailView.setupContent(movie: movie)
        movieDetailView.configureCollectionView(delegate: self, dataSource: self)
        movieDetailView.backBtnSelected = {
            [unowned self] in
            self.dismiss(animated: true)
        }
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            movieDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLayout() {
        view.addSubview(movieDetailView)
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as? CastCell else { return UICollectionViewCell() }
        cell.nameLbl.text = castModel[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
