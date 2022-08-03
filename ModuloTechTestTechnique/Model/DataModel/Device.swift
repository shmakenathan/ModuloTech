//
//  Device.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//
class Device: Codable {
    let id: Int
    let deviceName: String
    var intensity: Int?
    var mode: Mode?
    let productType: ProductType
    var position: Int?
    var temperature: Double?
}
