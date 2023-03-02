//
//  ArticlePriceFormatterUseCase.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import Foundation

protocol ArticlePriceFormatterUseCaseProtocol {
    func getFormattedPrice(_ price: Double?) -> String?
}

class ArticlePriceFormatterUseCase: ArticlePriceFormatterUseCaseProtocol {
    func getFormattedPrice(_ price: Double?) -> String? {
        guard let price = price else { return nil }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        guard let formattedPrice = formatter.string(from: price as NSNumber) else { return nil }

        return "Prix: \(formattedPrice)"
    }
}

private struct ArticlePriceFormatterUseCaseKey: InjectionKey {
    static var currentValue: ArticlePriceFormatterUseCaseProtocol = ArticlePriceFormatterUseCase()
}

extension InjectedValues {
    var articlePriceFormatterUseCase: ArticlePriceFormatterUseCaseProtocol {
        get { Self[ArticlePriceFormatterUseCaseKey.self] }
        set { Self[ArticlePriceFormatterUseCaseKey.self] = newValue }
    }
}
