//
//  FavoriteGame.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/10/21.
//
import CoreData

struct FavoriteGame {
    let game: Favorite

    var objectId: NSManagedObjectID {
        return game.objectID
    }

    var gameId: Int {
        return Int(game.gameId)
    }

    var name: String {
        return game.name ?? ""
    }

    var rating: Float {
        return game.rating
    }

    var releasedDate: String {
        return game.releasedDate ?? "-"
    }

    var backgroundImage: String {
        return game.backgroundImage ?? "-"
    }
}
