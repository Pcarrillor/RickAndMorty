//
//  LocationDetailModel.swift
//  RickyMorty
//
//  Created by Admin on 23/09/23.
//

import Foundation

// MARK: - LocationDetail
struct LocationDetail: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
