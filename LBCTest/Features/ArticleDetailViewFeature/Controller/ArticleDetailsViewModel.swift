//
//  ArticleDetailsViewModel.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import Foundation

final class ArticleDetailsViewModel {
    let articleUIModel: ArticleUIModel
    var didFetchImageClosure: ((Data?) -> ())?
    @Injected(\.imageLoaderRepository) var imageLoaderRepository: ImageLoaderRepositoryProtocol

    init(articleUIModel: ArticleUIModel) {
        self.articleUIModel = articleUIModel
        fetchImage()
    }

    func fetchImage() {
        Task {
            await fetchArticleImage(with: articleUIModel.imagesUrl?.thumb)
        }
    }

    @MainActor
    private func fetchArticleImage(with url: String?) async {
        do {
            let imageData = try await imageLoaderRepository.getImage(with: url)
            if let imageData = imageData {
                didFetchImageClosure?(imageData)
            } else {
                didFetchImageClosure?(nil)
            }
        } catch {
            didFetchImageClosure?(nil)
        }
    }
}
