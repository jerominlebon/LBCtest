//
//  HomeViewModelTests.swift
//  LBCTestTests
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import XCTest
@testable import LBCTest

final class HomeViewModelTests: XCTestCase {
    var homeViewModel = HomeViewModel()
    var mock = HomeDataSourceMock()

    override func setUpWithError() throws {
        mock.fetchedArticles = [
            ArticleDataModel(
                id: 0,
                categoryId: 1,
                title: "Article 1",
                description: "C'est l'article 1",
                price: 10.00,
                imagesUrl: nil,
                creationDate: "2019-11-05T20:02:29+0000",
                isUrgent: true,
                siret: nil
            ),
            ArticleDataModel(
                id: 1,
                categoryId: 2,
                title: "Article 2",
                description: "Super article 2",
                price: 24.00,
                imagesUrl: ImageUrl(thumb: "url1", small: "url2"),
                creationDate: "2019-11-05T20:01:58+0000",
                isUrgent: false,
                siret: "341 884 222"
            )
        ]

        mock.fetchedCategories = [
            CategoryDataModel(
                id: 0, name: "Vidéo"
            ),
            CategoryDataModel(
                id: 2, name: "Musique"
            )
        ]
        InjectedValues[\.homeDataSource] = mock
    }

    override func tearDownWithError() throws {
        mock.fetchedArticles = []
        mock.fetchedCategories = []
        mock.isFetchedCategoriesInError = false
        mock.isFetchedArticlesInError = false
    }

    func testDataMapping() async throws {
        homeViewModel.reloadTableViewClosure = { [weak self] in
            XCTAssertEqual(self?.homeViewModel.articles.count, 2)
            XCTAssertEqual(self?.homeViewModel.articles[0], ArticleUIModel(
                id: 0,
                categoryName: nil,
                title: "Article 1",
                description: "C'est l'article 1",
                formattedPrice: "Prix: 10,00 €",
                imagesUrl: nil,
                formattedCreationDate: "Le 05/11/2019 à 09:02",
                isUrgent: true,
                siret: nil
            ))
            XCTAssertEqual(self?.homeViewModel.articles[1], ArticleUIModel(
                id: 1,
                categoryName: "Musique",
                title: "Article 2",
                description: "Super article 2",
                formattedPrice: "Prix: 24,00 €",
                imagesUrl: ImageUrl(thumb: "url1", small: "url2"),
                formattedCreationDate: "Le 05/11/2019 à 09:01",
                isUrgent: false,
                siret: "341 884 222"
            ))
            XCTAssertEqual(self?.homeViewModel.cellViewModels.count, 2)
        }

        await homeViewModel.getArticles()
    }

    func testErrorRetrievingDatas() async {
        mock.isFetchedArticlesInError = true
        mock.isFetchedCategoriesInError = true

        homeViewModel.didGetErrorClosure = { [weak self] in
            XCTAssertEqual(self?.homeViewModel.articles.count, 0)
        }

        await homeViewModel.getArticles()

    }

    func testArticleSelection() async throws {
        await homeViewModel.getArticles()

        homeViewModel.didPressClosure = { selectedArticle in
            let uiModel = selectedArticle.articleUIModel
            XCTAssertEqual(uiModel, ArticleUIModel(
                id: 1,
                categoryName: "Musique",
                title: "Article 2",
                description: "Super article 2",
                formattedPrice: "Prix: 24,00 €",
                imagesUrl: ImageUrl(thumb: "url1", small: "url2"),
                formattedCreationDate: "Le 05/11/2019 à 09:01",
                isUrgent: false,
                siret: "341 884 222"
            ))
        }

        let indexPath = IndexPath(row: 1, section: 0)
        homeViewModel.didPressArticle(at: indexPath)
    }
}
