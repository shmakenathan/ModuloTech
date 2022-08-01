//
//  Device.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//
struct Device: Codable {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: Mode?
    let productType: ProductType
    let position, temperature: Int?
}
