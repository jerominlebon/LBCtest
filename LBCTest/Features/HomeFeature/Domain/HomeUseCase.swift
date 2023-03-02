//
//  HomeUseCase.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 28/02/2023.
//

import Foundation

protocol HomeUseCaseProtocol {
    func getArticles() async throws -> [ArticleDomainModel]
}

class HomeUseCase: HomeUseCaseProtocol {
    @Injected(\.homeDataSource) var homeDataSource: HomeDataSourceProtocol

    func getArticles() async throws -> [ArticleDomainModel] {
        async let articlesData = homeDataSource.fetchArticles()
        async let categoriesData = homeDataSource.fetchCategories()

        let (fetchedArticlesData, fetchedCategoriesData) = try await (articlesData, categoriesData)

        let articlesDomains = fetchedArticlesData.map { articleData in
            ArticleDomainModel(
                id: articleData.id,
                categoryName: fetchedCategoriesData.first(where: { category in
                    category.id == articleData.categoryId
                })?.name,
                title: articleData.title,
                description: articleData.description,
                price: articleData.price,
                imagesUrl: articleData.imagesUrl,
                creationDate: articleData.creationDate,
                isUrgent: articleData.isUrgent ?? false,
                siret: articleData.siret
            )
        }
        return articlesDomains
    }
}

private struct HomeUseCaseKey: InjectionKey {
    static var currentValue: HomeUseCaseProtocol = HomeUseCase()
}

extension InjectedValues {
    var homeUseCase: HomeUseCaseProtocol {
        get { Self[HomeUseCaseKey.self] }
        set { Self[HomeUseCaseKey.self] = newValue }
    }
}
