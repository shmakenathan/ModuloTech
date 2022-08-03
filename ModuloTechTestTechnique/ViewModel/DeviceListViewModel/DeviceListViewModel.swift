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


