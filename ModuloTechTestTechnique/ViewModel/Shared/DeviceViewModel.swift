//
//  DeviceViewModel.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//

import Foundation
import RxRelay


enum DeviceControlOptionType {
    case slider
    case stepper
    case toggleSwitch
}



final class DeviceViewModel {
    
    init(device: Device) {
        self.device = device
        isOnRelay.accept(device.mode == .on)
        stepperValueRelay.accept(Double(device.temperature ?? 0))
        sliderValueRelay.accept(sliderValue)
    }
    
    
    private var sliderValue: Int {
        switch device.productType {
        case .rollerShutter: return device.position ?? 0
        case .light: return device.intensity ?? 0
        case .heater: return 0
        }
    }
    
    
    let sliderValueRelay = BehaviorRelay<Int>(value: 0)
    
    
    func assignNewSliderValue(value: Int) {
        switch device.productType {
        case .rollerShutter:
            device.position = value
        case .light:
           device.intensity = value
        case .heater:
            break
        }
        

        sliderValueRelay.accept(sliderValue)
    }
    
    let stepperValueRelay = BehaviorRelay<Double>(value: 20)
    
    private let stepperIncrementValue = 0.5
    private let maxStepperValue = 28.0
    private let minStepperValue = 7.0
    
    func increaseStepperValue() {
        
  
        
        guard let deviceTemperature = device.temperature,
              deviceTemperature <= (maxStepperValue - stepperIncrementValue)
        else {
            return

        }
       
        device.temperature = deviceTemperature + 0.5
        stepperValueRelay.accept(Double(device.temperature ?? 0))
    }
    
    func decreaseStepperValue() {
        guard let deviceTemperature = device.temperature,
              deviceTemperature >= (minStepperValue + stepperIncrementValue)
        else {
            return
          
        }
       
        device.temperature = deviceTemperature - 0.5
        stepperValueRelay.accept(Double(device.temperature ?? 0))
    }
    
    
    let isOnRelay = BehaviorRelay<Bool>(value: false)
    private let device: Device
    
    func toggleSwitch() {
        let newMode: Mode = device.mode == .off ? .on : .off
        device.mode = newMode
        let isOn = newMode == .on
        isOnRelay.accept(isOn)
    }
    
    
    
    
    var deviceControlOptionTypes: [DeviceControlOptionType] {
        switch device.productType {
        case .heater: return [.toggleSwitch, .stepper]
        case .light: return [.toggleSwitch, .slider]
        case .rollerShutter: return [.slider]
        }
    }
    
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
            return Strings.opened
        case 1...99:
            return Strings.openedAt + String(position) + "%"
        case 0:
            return Strings.closed
        default:
            return undefinedDescription
        }
    }
    
    private var lightStateDescription: String {
        let undefinedDescription = "Unknown"
        guard let mode = device.mode else { return undefinedDescription }
        
        switch mode {
        case .on: return Strings.on
        case .off: return Strings.off
        }
    }
    
    private var heaterStateDescription: String {
        let undefinedDescription = "Unknown"
        guard let mode = device.mode else { return undefinedDescription }
        
        switch mode {
        case .on: return Strings.onAt + "\(device.temperature?.description ?? "--")°C"
        case .off: return Strings.off
        }
    }
}
