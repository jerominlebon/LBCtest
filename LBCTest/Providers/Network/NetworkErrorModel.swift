//
//  NetworkErrorModel.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 27/02/2023.
//

enum NetworkError: Error {
    case badUrl
    case badRequest
    case statusCode
    case serializing
    case other(Error)

    static func map(_ error: Error) -> NetworkError {
        return (error as? NetworkError) ?? .other(error)
    }
}
