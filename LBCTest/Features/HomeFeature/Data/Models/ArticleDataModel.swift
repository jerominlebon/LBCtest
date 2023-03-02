//
//  ArticleDataModel.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 27/02/2023.
//

import Foundation

struct ArticleDataModel: Codable {
    let id: Int?
    let categoryId: Int?
    let title: String?
    let description: String?
    let price: Double?
    let imagesUrl: ImageUrl?
    let creationDate: String?
    let isUrgent: Bool?
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case description
        case price
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}

struct ImageUrl: Codable, Equatable {
    let thumb: String?
    let small: String?
}
