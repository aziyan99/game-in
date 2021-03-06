//
//  GameDetail.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 15/09/21.
//

struct GameDetail: Codable {
    let name: String
    let descriptionRaw: String
    let backgroundImage: String
    let website: String
    let rating: Float
    let updated: String
    let released: String
    let developers: [Developer]
    let platforms: [Platform]
}
