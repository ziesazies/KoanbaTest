//
//  ViewController.swift
//  Movie
//
//  Created by Phincon on 09/07/24.
//

import UIKit
import Combine
import NetworkModule
import Domain

class ListMovieViewController: UIViewController {
    
    private lazy var listMovieView: ListMovieView = {
        let view = ListMovieView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var viewModel = ListMovieViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private var tableViewHandler: ListMovieDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViews()
        setupConstraints()
        bindViewModel()
        callApi()
        setupPullToRefresh()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(listMovieView)
    }
    
    private func setupTableView(){
        tableViewHandler = ListMovieDataSource(viewModel: viewModel, view: self)
        listMovieView.tableView.delegate = tableViewHandler
        listMovieView.tableView.dataSource = tableViewHandler
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            listMovieView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listMovieView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listMovieView.topAnchor.constraint(equalTo: view.topAnchor),
            listMovieView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$listMovies
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.listMovieView.tableView.refreshControl?.endRefreshing()
                self.listMovieView.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$searchResults
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.listMovieView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func callApi() {
        viewModel.getGenre()
        viewModel.setupSearchMovie(searchField: listMovieView.searchField)
        viewModel.fetchListMovie()
    }
    
    private func setupPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        listMovieView.tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        viewModel.refreshListMovie()
    }
}
