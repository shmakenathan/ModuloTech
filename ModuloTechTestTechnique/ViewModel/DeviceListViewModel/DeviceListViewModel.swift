//
//  DeviceListViewModel.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//

import Foundation
import RxSwift

final class DeviceListViewModel {
    
    init(deviceService: DeviceService = DeviceService.shared) {
        self.deviceService = deviceService
    }
    
    let title = Strings.myDevices
    
    var deviceViewModelsSubject = BehaviorSubject<[DeviceViewModel]>(value: [])
    var deviceViewModels: [DeviceViewModel] = [] {
        didSet {
            deviceViewModelsSubject.on(.next(deviceViewModels))
        }
    }
    
    func fetchDevicesData() {
        Task {
            do {
                
                let devices = try await deviceService.fetchDevices()
                
                self.deviceViewModels = devices.map {
                    DeviceViewModel(device: $0)
                }
            } catch {
                print("SHOULD PRESENT ERROR")
            }
            
        }
    }
    
    private let deviceService: DeviceService
}




enum DeviceServiceError: Error {
    case failedToFetchDevices
}

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
