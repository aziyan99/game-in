//
//  Game.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

struct Game: Identifiable, Codable {
    let id: Int
    let name: String
    let rating: Float
    let backgroundImage: String
    let released: String
}
