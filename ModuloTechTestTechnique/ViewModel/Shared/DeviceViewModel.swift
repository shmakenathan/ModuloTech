//
//  DeviceViewModel.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//

import Foundation


final class DeviceViewModel {
    
    init(device: Device) {
        self.device = device
    }
    
    let device: Device
    
    
    var deviceName: String {
        device.deviceName
    }
    
    var iconImageName: String? {
        switch device.productType {
        case .rollerShutter:
            return rollerShutterImageName
        case .light:
            return lightStateImageName
        case .heater:
            return heaterStateImageName
        }
    }
    
    var stateDescription: String {
        switch device.productType {
        case .rollerShutter:
            return rollerShutterStateDescription
        case .light:
            return lightStateDescription
        case .heater:
            return heaterStateDescription
        }
    }
    
    private var rollerShutterImageName: String? {
        return "DeviceRollerShutterIcon"
    }
    
    private var lightStateImageName: String? {
        switch device.mode {
        case.none: return nil
        case .on: return "DeviceLightOnIcon"
        case .off: return "DeviceLightOffIcon"
        }
    }
    
    private var heaterStateImageName: String? {
        switch device.mode {
        case.none: return nil
        case .on: return "DeviceHeaterOnIcon"
        case .off: return "DeviceHeaterOffIcon"
        }
    }
    
    
    //---------
    
   
    
    private var rollerShutterStateDescription: String {
        let undefinedDescription = "Unknown"
        guard let position = device.position else { return undefinedDescription }
        
        switch position {
        case 100:
            return "Opened"
        case 1...99:
            return "Opened at \(position)%"
        case 0:
            return "Closed"
        default:
            return undefinedDescription
        }
    }
    
    private var lightStateDescription: String {
        let undefinedDescription = "Unknown"
        guard let mode = device.mode else { return undefinedDescription }
        
        switch mode {
        case .on: return "On"
        case .off: return "Off"
        }
    }
    
    private var heaterStateDescription: String {
        let undefinedDescription = "Unknown"
        guard let mode = device.mode else { return undefinedDescription }
        
        switch mode {
        case .on: return "On at \(device.temperature?.description ?? "--")°C"
        case .off: return "Off"
        }
    }
}
