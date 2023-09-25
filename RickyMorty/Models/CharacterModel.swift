//
//  CharacterModel.swift
//  RickyMorty
//
//  Created by Admin on 23/09/23.
//
//   let characters = try? JSONDecoder().decode(Characters.self, from: jsonData)

import Foundation

// MARK: - CharactersModel
struct CharactersModel: Codable {
    let info: Info
    var results: [Result]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next, prev: String?
}

// MARK: - Result
struct Result: Codable, Identifiable, Hashable {
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let status: String
    let species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable, Hashable{
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
