//
//  User.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//

struct User: Codable {
    let firstName, lastName: String
    let address: Address
    let birthDate: Int
}
