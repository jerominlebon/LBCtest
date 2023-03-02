//
//  ArticlePriceFormatterUseCaseTests.swift
//  LBCTestTests
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import XCTest
@testable import LBCTest

final class ArticlePriceFormatterUseCaseTests: XCTestCase {
    let articlePriceFormatterUseCase: ArticlePriceFormatterUseCaseProtocol = ArticlePriceFormatterUseCase()

    func testPriceFormatter() throws {
        let formattedPrice1 = try XCTUnwrap(articlePriceFormatterUseCase.getFormattedPrice(23.00))
        XCTAssertEqual(formattedPrice1, "Prix: 23,00 €")

        let formattedPrice2 = try XCTUnwrap(articlePriceFormatterUseCase.getFormattedPrice(144.99))
        XCTAssertEqual(formattedPrice2, "Prix: 144,99 €")

        let formattedPrice3 = try XCTUnwrap(articlePriceFormatterUseCase.getFormattedPrice(75000.00))
        XCTAssertEqual(formattedPrice3, "Prix: 75 000,00 €")
    }

    func testPriceFormatterError() throws {
        let formattedPrice1 = articlePriceFormatterUseCase.getFormattedPrice(nil)
        XCTAssertEqual(formattedPrice1, nil)
    }
}
