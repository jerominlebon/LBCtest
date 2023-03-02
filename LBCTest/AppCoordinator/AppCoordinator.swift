//
//  AppCoordinator.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 27/02/2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: false)
    }

    func goToArticleDetails(with viewModel: ArticleDetailsViewModel) {
        let articleDetailsViewController = ArticleDetailsViewController(with: viewModel)
        navigationController.pushViewController(articleDetailsViewController, animated: true)
    }
}
