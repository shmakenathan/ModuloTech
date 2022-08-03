//
//  DeviceService.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 03/08/2022.
//

import Foundation

final class DeviceService {
    static let shared = DeviceService()
    
    func fetchDevices() async throws -> [Device] {
        guard let localDevices = localDevices else {
            let fetchedDevices = try await fetchDevicesFromServer()
            print("PROVIDE DEVICES FROM SERVER❌❌")
            self.localDevices = fetchedDevices
            return fetchedDevices
        }
        
        print("PROVIDE DEVICES FROM LOCAL✅✅")
        return localDevices
    }

    private func fetchDevicesFromServer() async throws -> [Device] {
        let url = URL(string: "http://storage42.com/modulotest/data.json")!
        let urlRequest = URLRequest(url: url)
        guard let response: DevicesResponse = try? await networkService.fetch(urlRequest: urlRequest) else {
            throw DeviceServiceError.failedToFetchDevices
        }
        return response.devices
    }
    
    private var localDevices: [Device]?
    
    private let networkService = NetworkService.shared
}
