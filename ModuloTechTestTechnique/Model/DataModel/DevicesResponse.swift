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



