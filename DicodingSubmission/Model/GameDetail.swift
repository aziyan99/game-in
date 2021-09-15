//
//  GameDetail.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 15/09/21.
//

import Foundation

struct GameDetail: Codable {
    let name: String
    let description_raw: String
    let background_image: String
    let reddit_url: String
    let website: String
    let developers: [Developer]
}
