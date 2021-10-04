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

    func getGameById(id: NSManagedObjectID) -> Favorite? {
        do {
            return try viewContext.existingObject(with: id) as? Favorite
        } catch {
            return nil
        }
    }

    func deleteGame(game: Favorite) {
        viewContext.delete(game)
        save()
    }
}
