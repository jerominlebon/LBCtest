//
//  ArticleDomainModel.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 28/02/2023.
//

import Foundation

struct ArticleDomainModel: Equatable {
    let id: Int?
    let categoryName: String?
    let title: String?
    let description: String?
    let price: Double?
    let imagesUrl: ImageUrl?
    let creationDate: String?
    let isUrgent: Bool?
    let siret: String?
}
