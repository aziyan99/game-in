//
//  Game.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

import Foundation

struct Game: Identifiable, Codable {
    let id: Int
    let name: String
    let rating: Float
    let background_image: String
}
