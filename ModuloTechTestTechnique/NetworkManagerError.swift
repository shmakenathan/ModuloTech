//
//  NetworkManagerError.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 25/07/2022.
//

import Foundation

enum NetworkManagerError: Error {
    case invalidResponseStatusCode
    case unknownErrorOccured
    case noData
    case couldNotDecodeJson
    
    var message: String {
        switch self {
        case .invalidResponseStatusCode: return "Invalid Response Status Code"
        case .couldNotDecodeJson: return "Unable to decode JSON file"
        case .noData: return "No data received"
        default: return "Unknown error"
        }
    }
    
}
