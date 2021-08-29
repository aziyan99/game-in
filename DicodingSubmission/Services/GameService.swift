//
//  GameServicw.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 29/08/21.
//

import Foundation

class GameService {
    func fetchGames(completion: @escaping ([GameModel]) -> Void) {
        completion([
            GameModel(id: 1, name: "nama game", rating: 2.0),
            GameModel(id: 2, name: "nama game", rating: 2.0),
            GameModel(id: 3, name: "nama game", rating: 2.0),
            GameModel(id: 4, name: "nama game", rating: 2.0),
            GameModel(id: 5, name: "nama game", rating: 2.0)
        ])
    }
}
