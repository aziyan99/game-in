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
    @Published var currentDate: String

    @Published var loading: Bool = false
    @Published var loaded: Bool = false
    @Published var noConnection: Bool = false
    @Published var somethingWrong: Bool = false

    let monitor = NWPathMonitor()

    init() {

        self.currentDate = getCurrentDate()

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.fetchGames()
            } else {
                DispatchQueue.main.async {
                    self.loading = false
                    self.loaded = false
                    self.somethingWrong = false
                    self.noConnection = true
                }
            }
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

    func fetchGames () {
        DispatchQueue.main.async {
            self.loaded = false
            self.noConnection = false
            self.somethingWrong = false
            self.loading = true
        }

        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let model = try JSONDecoder().decode(GameResult.self, from: data)
                DispatchQueue.main.async {
                    self.games = model.results
                    self.loaded = true
                    self.noConnection = false
                    self.somethingWrong = false
                    self.loading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.loaded = false
                    self.noConnection = false
                    self.loading = false
                    self.somethingWrong = true
                }
            }
        }

        task.resume()
    }
}
