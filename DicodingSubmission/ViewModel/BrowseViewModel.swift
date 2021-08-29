//
//  BrowseViewModel.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 29/08/21.
//

import Foundation
import Network


class BrowseViewModel: ObservableObject {
    
    @Published var games = [GameModel]()
    @Published var loading: Bool = false
    @Published var loaded: Bool = false
    @Published var failed: Bool = false
    
    let monitor = NWPathMonitor()
    
    init() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.fetchGames()
            } else {
                DispatchQueue.main.async {
                    self.failed = true
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func fetchGames() {
        DispatchQueue.main.async {
            self.loading = true
        }
        
        guard let url = URL(string: "https://api.rawg.io/api/games?key=2ddaf6bc17734aa4b0e1fea5ccad3163&page_size=40") else {
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
                    self.loading = false
                    self.loaded = true
                }
            }
            catch {
                print("Failed to cast data")
                self.loading = false
                self.failed = true
            }
        }
        task.resume()
    }
}
