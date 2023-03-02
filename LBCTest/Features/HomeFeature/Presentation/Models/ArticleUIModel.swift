//
//  ArticleUIModel.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 28/02/2023.
//

import Foundation

struct ArticleUIModel: Equatable {
    let id: Int?
    let categoryName: String?
    let title: String?
    let description: String?
    let formattedPrice: String?
    let imagesUrl: ImageUrl?
    let formattedCreationDate: String?
    let isUrgent: Bool?
    let siret: String?
}
