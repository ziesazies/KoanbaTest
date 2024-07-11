//
//  ListMovieView.swift
//  Movie
//
//  Created by Phincon on 10/07/24.
//

import Foundation
import UIKit

class ListMovieView: UIView {
    
    lazy var searchField: UITextField = {
        let search = UITextField()
        search.placeholder = "Search"
        search.borderStyle = .none
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addSubview(searchField)
        addSubview(separatorView)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        // constraint for search field
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // separator view
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            separatorView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            separatorView.topAnchor.constraint(equalTo: searchField.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // constraint tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
