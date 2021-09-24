//
//  SearchViewModel.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 21/09/21.
//

import Foundation
import Network

class SearchViewModel: ObservableObject {

    @Published var games = [Game]()

    @Published var loading: Bool = false
    @Published var loaded: Bool = false
    @Published var somethingWrong: Bool = false

    let monitor = NWPathMonitor()

    func fetchGames (searchText: String) {
        let url = "https://api.rawg.io/api/games?search=\(searchText.replacingOccurrences(of: " ", with: "%20"))&key=2ddaf6bc17734aa4b0e1fea5ccad3163"

        DispatchQueue.main.async {
            self.loaded = false
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
                    self.somethingWrong = false
                    self.loading = false
                    self.loaded = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.loaded = false
                    self.loading = false
                    self.somethingWrong = true
                }
            }
        }

        task.resume()
    }
}
