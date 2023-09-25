//
//  EspisodeDetailModel.swift
//  RickyMorty
//
//  Created by Admin on 23/09/23.
//

import Foundation

// MARK: - EpisodeDetail
struct EpisodeDetail: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
