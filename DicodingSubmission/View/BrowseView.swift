//
//  BrowseView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

import SwiftUI

struct BrowseView: View {

    @ObservedObject var viewModel = GameViewModel()

    init() {
        viewModel.fetchGames()
    }

    var body: some View {
        NavigationView {
            if viewModel.loading {
                VStack(alignment: .center) {
                    ProgressView()
                }
            } else if viewModel.noConnection {
                Label("No internet connection", systemImage: "wifi.exclamationmark")
            } else if viewModel.somethingWrong {
                Label("Failed to load data", systemImage: "xmark.octagon")
            } else {
                List {
                    ForEach(viewModel.games) { game in
                        NavigationLink(destination: GameDetailView(gameId: game.id)) {
                            GameCellView(name: game.name,
                                         rating: game.rating,
                                         released: game.released,
                                         gameId: game.id,
                                         backgroundImage: game.backgroundImage)
                        }

                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Browse")
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
