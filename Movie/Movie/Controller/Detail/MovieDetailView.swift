//
//  MovieDetailView.swift
//  Movie
//
//  Created by Phincon on 10/07/24.
//

import Foundation
import UIKit
import Domain

class MovieDetailView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var durationLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "1h 29m"
        return label
    }()
    
    lazy var hdImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ic_hd")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        return image
    }()
    
    lazy var genreLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    lazy var posterImg: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let overviewLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let castLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cast"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
        return cv
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    var backBtnSelected: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraint()
        backBtn.addTarget(self, action: #selector(backBtnAction(sender:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func backBtnAction(sender: UIButton){
        backBtnSelected?()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            // Constraints for scrollView
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            // Constraints for wrapperView
            wrapperView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            wrapperView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            // back button constraint
            backBtn.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            backBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backBtn.widthAnchor.constraint(equalToConstant: 40),
            backBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            // genre label constraint
            genreLbl.bottomAnchor.constraint(equalTo: posterImg.bottomAnchor, constant: -16),
            genreLbl.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            genreLbl.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            // duration Label constraint
            durationLbl.bottomAnchor.constraint(equalTo: genreLbl.topAnchor, constant: -6),
            durationLbl.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            // hd image constraint
            hdImage.leadingAnchor.constraint(equalTo: durationLbl.trailingAnchor, constant: 5),
            hdImage.widthAnchor.constraint(equalToConstant: 12),
            hdImage.heightAnchor.constraint(equalToConstant: 12),
            hdImage.centerYAnchor.constraint(equalTo: durationLbl.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            // titleLbl constraint
            titleLbl.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            titleLbl.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            titleLbl.bottomAnchor.constraint(equalTo: durationLbl.topAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            // poster image constraint
            posterImg.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            posterImg.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            posterImg.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            posterImg.heightAnchor.constraint(equalToConstant: 375)
        ])
        
        NSLayoutConstraint.activate([
            // overview constraint
            overviewLbl.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            overviewLbl.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            overviewLbl.topAnchor.constraint(equalTo: posterImg.bottomAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            // castLbl constraint
            castLbl.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            castLbl.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            castLbl.topAnchor.constraint(equalTo: overviewLbl.bottomAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            // collectionview constraint
            collectionView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: castLbl.bottomAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 124)
        ])
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(wrapperView)
        [posterImg, titleLbl, genreLbl, durationLbl, hdImage, overviewLbl, castLbl, collectionView, backBtn].forEach {
            wrapperView.addSubview($0)
        }
    }
    
    func setupContent(movie: ListMovieResult) {
        titleLbl.text = movie.title
        genreLbl.text = movie.getGenre()
        overviewLbl.text = movie.overview
        posterImg.downloaded(from: Constant.baseUrlImg + (movie.poster_path ?? ""))
    }
    
    func configureCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
}
