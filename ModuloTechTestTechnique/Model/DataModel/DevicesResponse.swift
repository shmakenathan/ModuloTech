//
//  DataResponse.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 25/07/2022.
//

import Foundation



// MARK: - DevicesResponse
struct DevicesResponse: Codable {
    let devices: [Device]
    let user: User
}

// MARK: - Device
struct Device: Codable {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: Mode?
    let productType: ProductType
    let position, temperature: Int?
}

enum Mode: String, Codable {
    case on = "ON"
    case off = "OFF"
}

enum ProductType: String, Codable {
    case heater = "Heater"
    case light = "Light"
    case rollerShutter = "RollerShutter"
}

// MARK: - User
struct User: Codable {
    let firstName, lastName: String
    let address: Address
    let birthDate: Int
}

// MARK: - Address
struct Address: Codable {
    let city: String
    let postalCode: Int
    let street, streetCode, country: String
}
