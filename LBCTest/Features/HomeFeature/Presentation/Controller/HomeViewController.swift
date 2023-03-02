//
//  HomeViewController.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 27/02/2023.
//

import UIKit

class HomeViewController: UIViewController {
    private let tableView = UITableView()
    private let errorView = ErrorView()
    weak var coordinator: AppCoordinator?
    @Injected(\.homeViewModel) var viewModel: HomeViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        viewModel.initViewModel()
        bindVM()
        configureTableView()
        configureErrorView()
    }

    private func bindVM() {
        viewModel.reloadTableViewClosure = { [weak self] in
            self?.errorView.isHidden = true
            self?.tableView.reloadData()
        }

        viewModel.didPressClosure = { [weak self] detailViewModel in
            self?.coordinator?.goToArticleDetails(with: detailViewModel)
        }

        viewModel.didGetErrorClosure = { [weak self] in
            self?.errorView.isHidden = false
        }
    }
}

// MARK: - setupUI
private extension HomeViewController {
    func configureTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)

        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self
    }

    func configureErrorView() {
        self.view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        let errorViewConstraints = [
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(errorViewConstraints)
        errorView.delegate = self
        errorView.isHidden = true
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier) as? ArticleTableViewCell else { fatalError() }
        articleCell.viewModel = viewModel.cellViewModels[indexPath.row]
        return articleCell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didPressArticle(at: indexPath)
    }
}

extension HomeViewController: ErrorViewDelegate {
    func didTapRetryButton() {
        viewModel.initViewModel()
    }
}
