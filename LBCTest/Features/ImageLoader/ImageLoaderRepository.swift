//
//  ImageLoaderRepository.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 28/02/2023.
//

import UIKit

protocol ImageLoaderRepositoryProtocol {
    func getImage(with url: String?) async throws -> Data?
}

class ImageLoaderRepository: ImageLoaderRepositoryProtocol {
    @Injected(\.cacheProvider) var cache: CacheProviderProtocol
    @Injected(\.imageLoaderDataSource) var imageLoaderDataSource: ImageLoaderDataSourceProtocol

    func getImage(with url: String?) async throws -> Data? {
        guard let url = url else { throw NetworkError.badUrl }

        if let cachedDataImage = cache.get(path: url) {
            return cachedDataImage as? Data
        } else {
            let imageData = try? await imageLoaderDataSource.fetchImage(with: url)
            if let imageData = imageData {
                cache.set(object: imageData as AnyObject, for: url)
            }
            return imageData
        }
    }
}

private struct ImageLoaderRepositoryKey: InjectionKey {
    static var currentValue: ImageLoaderRepositoryProtocol = ImageLoaderRepository()
}

extension InjectedValues {
    var imageLoaderRepository: ImageLoaderRepositoryProtocol {
        get { Self[ImageLoaderRepositoryKey.self] }
        set { Self[ImageLoaderRepositoryKey.self] = newValue }
    }
}

