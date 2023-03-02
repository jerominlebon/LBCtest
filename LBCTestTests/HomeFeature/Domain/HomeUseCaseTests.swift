//
//  HomeUseCaseTests.swift
//  LBCTestTests
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import XCTest
@testable import LBCTest

final class HomeUseCaseTests: XCTestCase {
    var homeUseCase: HomeUseCaseProtocol = HomeUseCase()
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
    }

    func testCategoryAggregation() async throws {
            let articles = try await homeUseCase.getArticles()

            XCTAssert(articles.count == 2)
            XCTAssertEqual(articles[0].categoryName, nil)
            XCTAssertEqual(articles[1].categoryName, "Musique")
    }

    func testDataMapping() async throws {
        let articles = try await homeUseCase.getArticles()
        
        XCTAssertEqual(articles.count, 2)
        XCTAssertEqual(articles[0], ArticleDomainModel(
            id: 0,
            categoryName: nil,
            title: "Article 1",
            description: "C'est l'article 1",
            price: 10.00,
            imagesUrl: nil,
            creationDate: "2019-11-05T20:02:29+0000",
            isUrgent: true,
            siret: nil
        ))
        XCTAssert(articles[1] == ArticleDomainModel(
            id: 1,
            categoryName: "Musique",
            title: "Article 2",
            description: "Super article 2",
            price: 24.00,
            imagesUrl: ImageUrl(thumb: "url1", small: "url2"),
            creationDate: "2019-11-05T20:01:58+0000",
            isUrgent: false,
            siret: "341 884 222"
        ))
    }
}
