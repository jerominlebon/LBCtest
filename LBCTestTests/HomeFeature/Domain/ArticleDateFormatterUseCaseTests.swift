//
//  ArticleDateFormatterUseCaseTests.swift
//  LBCTestTests
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import XCTest
@testable import LBCTest

final class ArticleDateFormatterUseCaseTests: XCTestCase {
    let articleDateFormatterUseCase: ArticleDateFormatterUseCaseProtocol = ArticleDateFormatterUseCase()

    func testDateFormatter() throws {
        let formattedDate1 = try XCTUnwrap(articleDateFormatterUseCase.getFormattedDate("2019-11-05T20:01:08+0000"))
        XCTAssertEqual(formattedDate1, "Le 05/11/2019 à 09:01")

        let formattedPrice2 = try XCTUnwrap(articleDateFormatterUseCase.getFormattedDate("2019-11-05T20:00:45+0000"))
        XCTAssertEqual(formattedPrice2, "Le 05/11/2019 à 09:00")

        let formattedPrice3 = try XCTUnwrap(articleDateFormatterUseCase.getFormattedDate("2019-11-06T11:21:53+0000"))
        XCTAssertEqual(formattedPrice3, "Le 06/11/2019 à 12:21")
    }

    func testDateFormatterError() throws {
        let formattedDate1 = articleDateFormatterUseCase.getFormattedDate(nil)
        XCTAssertEqual(formattedDate1, nil)
    }
}
