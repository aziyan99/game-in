//
//  HighlightView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 26/08/21.
//

import SwiftUI

struct BrowseView: View {
    
    @StateObject var viewModel = BrowseViewModel()
    
    var body: some View {
        NavigationView {
            List (viewModel.games) { game in
                Text(game.name)
            }
            .navigationTitle("Browse")
        }
    }
}

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


struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
