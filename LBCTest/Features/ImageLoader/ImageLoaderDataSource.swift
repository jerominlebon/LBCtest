//
//  ImageLoaderDataSource.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 28/02/2023.
//

import Foundation

protocol ImageLoaderDataSourceProtocol {
    func fetchImage(with url: String?) async throws -> Data?
}

class ImageLoaderDataSource: ImageLoaderDataSourceProtocol {
    @Injected(\.networkProvider) var network: NetworkProviderProtocol

    func fetchImage(with url: String?) async throws -> Data? {
        guard let url = url else { return nil }

        let data = try await network.request(endpoint: .image(url))

        return data
    }
}

private struct ImageLoaderDataSourceKey: InjectionKey {
    static var currentValue: ImageLoaderDataSourceProtocol = ImageLoaderDataSource()
}

extension InjectedValues {
    var imageLoaderDataSource: ImageLoaderDataSourceProtocol {
        get { Self[ImageLoaderDataSourceKey.self] }
        set { Self[ImageLoaderDataSourceKey.self] = newValue }
    }
}
