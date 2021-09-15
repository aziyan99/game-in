//
//  GameDetailViewModel.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 15/09/21.
//

import Foundation

import Network

class GameDetailViewModel: ObservableObject {
    
    var id: Int
    
    @Published var name: String = "-"
    @Published var description_raw: String = "-"
    @Published var background_image: String = "-"
    @Published var developer_name: String = "-"
    @Published var developer_image_background: String = "-"
    @Published var website: String = "-"
    @Published var redditUrl: String = "-"
    
    @Published var loading: Bool = false
    @Published var loaded: Bool = false
    @Published var noConnection: Bool = false
    
    let monitor = NWPathMonitor()
    
    init(id: Int) {
        self.id = id
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.fetchGames()
            } else {
                DispatchQueue.main.async {
                    self.loading = false
                    self.loaded = false
                    self.noConnection = true
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func fetchGames () {
        let url = "https://api.rawg.io/api/games/\(self.id)?key=2ddaf6bc17734aa4b0e1fea5ccad3163"
        DispatchQueue.main.async {
            self.loaded = false
            self.noConnection = false
            self.loading = true
        }
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let model = try JSONDecoder().decode(GameDetail.self, from: data)
                DispatchQueue.main.async {
                    self.name = model.name
                    self.description_raw = model.description_raw
                    self.background_image = model.background_image
                    self.website = model.website
                    self.redditUrl = model.reddit_url
                    self.developer_name = model.developers[0].name
                    self.developer_image_background = model.developers[0].image_background
                    
                    self.loaded = true
                    self.noConnection = false
                    self.loading = false
                }
            } catch {
                self.loaded = false
                self.noConnection = false
                self.loading = true
            }
        }
        
        task.resume()
    }
}
