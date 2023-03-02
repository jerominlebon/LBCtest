//
//  HomeDataSourceMock.swift
//  LBCTestTests
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import Foundation
@testable import LBCTest

class HomeDataSourceMock: HomeDataSourceProtocol {

    var isFetchedArticlesInError = false
    var fetchedArticles: [ArticleDataModel] = []
    func fetchArticles() async throws -> [LBCTest.ArticleDataModel] {
        if isFetchedArticlesInError {
            throw NetworkError.serializing
        }
        return fetchedArticles
    }

    var isFetchedCategoriesInError = false
    var fetchedCategories: [CategoryDataModel] = []
    func fetchCategories() async throws -> [LBCTest.CategoryDataModel] {
        if isFetchedCategoriesInError {
            throw NetworkError.serializing
        }
        return fetchedCategories
    }
}
