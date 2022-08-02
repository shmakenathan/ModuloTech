//
//  DeviceListViewModel.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//

import Foundation
import RxSwift

final class DeviceListViewModel {
    private let networkService = NetworkService.shared
    
    let title = Strings.myDevices
    
    var deviceViewModelsSubject = BehaviorSubject<[DeviceViewModel]>(value: [])
    var deviceViewModels: [DeviceViewModel] = [] {
        didSet {
            deviceViewModelsSubject.on(.next(deviceViewModels))
        }
    }
    
    func fetchDevicesData() {
        Task {
            let url = URL(string: "http://storage42.com/modulotest/data.json")!
            let urlRequest = URLRequest(url: url)
            if let response: DevicesResponse = try? await networkService.fetch(urlRequest: urlRequest) {
                print("SUCCESS ✅✅")
                print(response)
                self.deviceViewModels = response.devices.map {
                    DeviceViewModel(device: $0)
                }
            
                
                
            } else {
                print("FAILED ❌❌❌")
            }
        }
    }
}
