//
//  HomeViewModel.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 28/02/2023.
//

import Foundation

final class HomeViewModel {
    @Injected(\.homeUseCase) var homeUseCase: HomeUseCaseProtocol
    @Injected(\.articleDateFormatterUseCase) var articleDateFormatterUseCase: ArticleDateFormatterUseCaseProtocol
    @Injected(\.articlePriceFormatterUseCase) var articlePriceFormatterUseCase: ArticlePriceFormatterUseCaseProtocol

    var articles: [ArticleUIModel] = []
    var cellViewModels: [ArticleTableViewCellViewModel] = [] {
        didSet {
            reloadTableViewClosure?()
        }
    }

    var numberOfCells: Int {
        return articles.count
    }

    var reloadTableViewClosure: (() -> ())?
    var didPressClosure: ((ArticleDetailsViewModel) -> ())?
    var didGetErrorClosure: (() -> ())?

    func initViewModel() {
        Task {
            await getArticles()
        }
    }

    @MainActor
    func getArticles() async {
        do {
            let articlesDomains = try await homeUseCase.getArticles()
            self.articles = mapToUI(articlesDomain: articlesDomains)
            mapToArticleCellViewModels(articles: self.articles)
        } catch {
            didGetErrorClosure?()
        }
    }

    func didPressArticle(at indexPath: IndexPath) {
        let articlePressed = self.articles[indexPath.row]
        self.didPressClosure?(ArticleDetailsViewModel(articleUIModel: articlePressed))
    }

    private func mapToUI(articlesDomain: [ArticleDomainModel]) -> [ArticleUIModel] {
        articlesDomain.map { article in
            ArticleUIModel(
                id: article.id,
                categoryName: article.categoryName,
                title: article.title,
                description: article.description,
                formattedPrice: articlePriceFormatterUseCase.getFormattedPrice(article.price),
                imagesUrl: article.imagesUrl,
                formattedCreationDate: articleDateFormatterUseCase.getFormattedDate(article.creationDate),
                isUrgent: article.isUrgent,
                siret: article.siret
            )
        }
    }

    private func mapToArticleCellViewModels(articles: [ArticleUIModel]) {
        self.cellViewModels = articles.map { ArticleTableViewCellViewModel(articleUIModel: $0) }
    }
}

private struct HomeViewModelKey: InjectionKey {
    static var currentValue: HomeViewModel = HomeViewModel()
}

extension InjectedValues {
    var homeViewModel: HomeViewModel {
        get { Self[HomeViewModelKey.self] }
        set { Self[HomeViewModelKey.self] = newValue }
    }
}
