//
//  MovieDetailCell.swift
//  Movie
//
//  Created by Phincon on 10/07/24.
//

import Foundation
import UIKit

final class CastCell: UICollectionViewCell {
    
    static let identifier = "MovieDetailCell"
    
    lazy var userImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 40
        img.clipsToBounds = true
        img.backgroundColor = .lightGray
        return img
    }()
    
    lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupConstraint(){
        // user image
        NSLayoutConstraint.activate([
            userImg.heightAnchor.constraint(equalToConstant: 80),
            userImg.widthAnchor.constraint(equalToConstant: 80),
            userImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        // name label
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: userImg.bottomAnchor, constant: 12),
            nameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLbl.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 12)
        ])
    }
    
    private func setupLayout(){
        contentView.addSubview(userImg)
        contentView.addSubview(nameLbl)
    }
}
