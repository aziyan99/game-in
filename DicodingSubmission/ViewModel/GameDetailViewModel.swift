//
//  GameDetailViewModel.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 15/09/21.
//

import Network

class GameDetailViewModel: ObservableObject {
    var gameId: Int
    @Published var name: String = "-"
    @Published var descriptionRaw: String = "-"
    @Published var backgroundImage: String = "-"
    @Published var developerName: String = "-"
    @Published var developerImageBackground: String = "-"
    @Published var website: String = "-"
    @Published var rating: Float = 1.1
    @Published var released: String = "-"
    @Published var updated: String = "-"
    @Published var minimumPcRequirement: String = "-"
    @Published var recommendedPcRequirement: String = "-"
    @Published var loading: Bool = false
    @Published var loaded: Bool = false
    @Published var noConnection: Bool = false
    @Published var somethingWrong: Bool = false
    let monitor = NWPathMonitor()

    init(gameId: Int) {
        self.gameId = gameId
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
        let url = formingUrl(gameId: self.gameId)
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model = try decoder.decode(GameDetail.self, from: data)
                DispatchQueue.main.async {
                    self.name = model.name
                    self.descriptionRaw = model.descriptionRaw
                    self.backgroundImage = model.backgroundImage
                    self.website = model.website
                    self.released = model.released
                    self.updated = model.updated
                    self.rating = model.rating
                    let minimumPcRequirement = model.platforms.filter { $0.platform?.name == "PC" }
                    if minimumPcRequirement.count < 1 {
                        self.minimumPcRequirement = "Not available in PC"
                    } else {
                        self.minimumPcRequirement = minimumPcRequirement[0]
                            .requirements?.minimum ?? "Not available in PC"
                        self.recommendedPcRequirement = minimumPcRequirement[0]
                            .requirements?.recommended ?? "Not available in PC"
                    }
                    if model.developers.count < 1 {
                        self.developerName = "Not found"
                        self.developerImageBackground = "https://img.icons8.com/windows/32/000000/nothing-found.png"
                    } else {
                        self.developerName = model.developers[0].name
                        self.developerImageBackground = model.developers[0].imageBackground
                    }
                    self.loaded = true
                    self.noConnection = false
                    self.loading = false
                    self.somethingWrong = false
                }
            } catch {
                self.loaded = false
                self.noConnection = false
                self.somethingWrong = false
                self.loading = true
            }
        }

        task.resume()
    }

    public func formingUrl(gameId: Int) -> String {
        return "https://api.rawg.io/api/games/\(gameId)?key=2ddaf6bc17734aa4b0e1fea5ccad3163"
    }
}
