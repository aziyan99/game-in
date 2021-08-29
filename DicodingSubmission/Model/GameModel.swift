//
//  GameModel.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 29/08/21.
//

import Foundation


struct GameResultModel: Codable {
    let results: [GameModel]
}

struct GameModel: Identifiable, Codable {
    var id: Int
    let name: String
    let rating: Float
    let background_image: String
    let released: String
}
