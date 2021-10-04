//
//  CoreDataManager.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 30/09/21.
//

import CoreData

class CoreDataManager {
    let persisntentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persisntentContainer.viewContext
    }

    private init() {
        persisntentContainer = NSPersistentContainer(name: "FavoriteGame")
        persisntentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unable to initialize coredata stack \(error)")
            }
        }
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }

    func getAllGames() -> [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    func getGameById(objectId: NSManagedObjectID) -> Favorite? {
        do {
            return try viewContext.existingObject(with: objectId) as? Favorite
        } catch {
            return nil
        }
    }

    func deleteGame(game: Favorite) {
        viewContext.delete(game)
        save()
    }

    func getGameByGameId(gameId: Int64) -> Bool {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(
            format: "gameId = %@", "\(gameId)"
        )
        do {
            let result = try viewContext.fetch(request)
            if result.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
