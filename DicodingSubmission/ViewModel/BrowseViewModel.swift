//
//  BrowseViewModel.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 29/08/21.
//

import Foundation

class BrowseViewModel: ObservableObject {
    @Published var games = [GameModel]()
    
    init() {
        fetchGames()
    }
    
    func fetchGames() {
        guard let url = URL(string: "https://api.rawg.io/api/games?key=2ddaf6bc17734aa4b0e1fea5ccad3163") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            //convert data
            do {
                let model = try JSONDecoder().decode(GameResultModel.self, from: data)
                DispatchQueue.main.async {
                    self.games = model.results
                }
            }
            catch {
                print("Failed to cast data")
            }
        }
        task.resume()
    }
}
