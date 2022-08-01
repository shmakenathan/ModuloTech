//
//  Adress.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//
struct Address: Codable {
    let city: String
    let postalCode: Int
    let street, streetCode, country: String
}
