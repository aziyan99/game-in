//
//  FavoriteGameViewModel.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 30/09/21.
//
import CoreData

class FavoriteGameViewModel: ObservableObject {
    var gameId: Int64 = 0
    var name: String = "-"
    var rating: Float = 1.1
    var releasedDate: String = "-"
    var backgroundImage: String = "-"
    @Published var games: [FavoriteGame] = []

    init() {
        games = CoreDataManager.shared.getAllGames().map(FavoriteGame.init)
    }

    func save(gameId: Int64, name: String, rating: Float, releasedDate: String, backgroundImage: String) {
        let favorite = Favorite(context: CoreDataManager.shared.persisntentContainer.viewContext)
        favorite.gameId = gameId
        favorite.name = name
        favorite.rating = rating
        favorite.releasedDate = releasedDate
        favorite.backgroundImage = backgroundImage

        CoreDataManager.shared.save()
    }

    func getAllGames() {
        games = []
        games = CoreDataManager.shared.getAllGames().map(FavoriteGame.init)
    }

    func delete(_ game: FavoriteGame) {
        let existingFavoritedGame = CoreDataManager.shared.getGameById(id: game.objectId)
        if let existingFavoritedGame = existingFavoritedGame {
            CoreDataManager.shared.deleteGame(game: existingFavoritedGame)
        }
    }
}
