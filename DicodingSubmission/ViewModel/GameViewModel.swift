//
//  GameViewModel.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

import Foundation
import Network

class GameViewModel: ObservableObject {
    private let url = "https://api.rawg.io/api/games?key=2ddaf6bc17734aa4b0e1fea5ccad3163"
    
    @Published var games = [Game]()
    @Published var state: AppState = AppState.idle
    
    let monitor = NWPathMonitor()
    
    init() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.fetchGames()
            } else {
                DispatchQueue.main.async {
                    self.state = .failed
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func fetchGames () {
        DispatchQueue.main.async {
            self.state = .loading
        }
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let model = try JSONDecoder().decode(GameResult.self, from: data)
                DispatchQueue.main.async {
                    self.games = model.results
                    self.state = .loaded
                }
            } catch {
                self.state = .failed
            }
        }
        
        task.resume()
    }
}
