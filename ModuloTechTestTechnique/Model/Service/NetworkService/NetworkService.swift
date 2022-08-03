//
//  NetworkService.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 25/07/2022.
//





import Foundation
final class NetworkService {
    
    static let shared = NetworkService()
    let urlSession = URLSession(configuration: .default)
    let jsonDecoder = JSONDecoder()
    
    func fetch<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        guard let (data, response) = try? await urlSession.data(for: urlRequest) else {
            throw NetworkServiceError.failedToFetchUnknownError
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              Array(200...299).contains(httpResponse.statusCode) else {
            throw NetworkServiceError.failedToFetchInvalidStatusCode
        }
        
        
        do {
            let decodedData = try jsonDecoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print(error.localizedDescription)
            print(error)
            throw NetworkServiceError.failedToFetchDecodingFailed
        }
    }
}
