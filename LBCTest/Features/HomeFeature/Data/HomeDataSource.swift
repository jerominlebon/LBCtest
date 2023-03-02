//
//  HomeDataSource.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 27/02/2023.
//

import Foundation

protocol HomeDataSourceProtocol {
    func fetchArticles() async throws -> [ArticleDataModel]
    func fetchCategories() async throws -> [CategoryDataModel]
}

class HomeDataSource: HomeDataSourceProtocol {
    @Injected(\.networkProvider) var networkProvider: NetworkProviderProtocol

    func fetchArticles() async throws -> [ArticleDataModel] {
        let data = try await networkProvider.request(endpoint: .listing)

        guard let articles = try? JSONDecoder().decode([ArticleDataModel].self, from: data) else {
            throw NetworkError.serializing
        }

        return articles
    }

    func fetchCategories() async throws -> [CategoryDataModel] {
        let data = try await networkProvider.request(endpoint: .categories)

        guard let categories = try? JSONDecoder().decode([CategoryDataModel].self, from: data) else {
            throw NetworkError.serializing
        }

        return categories
    }
}

private struct HomeDataSourceKey: InjectionKey {
    static var currentValue: HomeDataSourceProtocol = HomeDataSource()
}

extension InjectedValues {
    var homeDataSource: HomeDataSourceProtocol {
        get { Self[HomeDataSourceKey.self] }
        set { Self[HomeDataSourceKey.self] = newValue }
    }
}
