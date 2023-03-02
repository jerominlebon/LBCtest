//
//  NetworkProvider.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 27/02/2023.
//

import Foundation

enum Endpoint {
    case listing
    case categories
    case image(String)

    var base: String {
        switch self {
        case .listing, .categories:
            return "https://raw.githubusercontent.com/leboncoin/paperclip/master"
        case .image:
            return ""
        }
    }

    var path: String {
        switch self {
        case .listing:
            return "/listing.json"
        case .categories:
            return "/categories.json"
        case .image(let url):
            return url
        }
    }
}

protocol NetworkProviderProtocol {
    func request(endpoint: Endpoint) async throws -> Data
}

class NetworkProvider: NetworkProviderProtocol {
    func request(endpoint: Endpoint) async throws -> Data {
        guard let url = URL(string: endpoint.base+endpoint.path)
        else {
            throw NetworkError.badUrl
        }

        let request = URLRequest(url: url)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw NetworkError.badRequest
        }

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.statusCode
        }

        return data
    }
}

private struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProviderProtocol = NetworkProvider()
}

extension InjectedValues {
    var networkProvider: NetworkProviderProtocol {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }
}
