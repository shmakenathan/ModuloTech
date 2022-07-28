//
//  NetworkServiceError.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//

import Foundation

enum NetworkServiceError: Error {
    case failedToFetchUnknownError
    case failedToFetchInvalidStatusCode
    case failedToFetchDecodingFailed
}
