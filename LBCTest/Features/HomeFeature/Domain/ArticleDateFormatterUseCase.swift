//
//  ArticleDateFormatterUseCase.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import Foundation

protocol ArticleDateFormatterUseCaseProtocol {
    func getFormattedDate(_ date: String?) -> String?
}

class ArticleDateFormatterUseCase: ArticleDateFormatterUseCaseProtocol {

    func getFormattedDate(_ date: String?) -> String? {
        guard let date = date else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrinter = DateFormatter()
        dateFormatterPrinter.dateFormat = "dd/MM/yyyy à hh:mm"

        guard let formattedDate = dateFormatter.date(from: date) else { return nil }
        return "Le \(dateFormatterPrinter.string(from: formattedDate))"
    }
}

private struct ArticleDateFormatterUseCaseKey: InjectionKey {
    static var currentValue: ArticleDateFormatterUseCaseProtocol = ArticleDateFormatterUseCase()
}

extension InjectedValues {
    var articleDateFormatterUseCase: ArticleDateFormatterUseCaseProtocol {
        get { Self[ArticleDateFormatterUseCaseKey.self] }
        set { Self[ArticleDateFormatterUseCaseKey.self] = newValue }
    }
}
