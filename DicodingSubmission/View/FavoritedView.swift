//
//  FavoritedView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 29/09/21.
//

import SwiftUI

struct FavoritedView: View {
    @StateObject private var viewModel = FavoriteGameViewModel()

    var body: some View {
        NavigationView {
                List {
                    ForEach(viewModel.games, id: \.gameId) { game in
                        NavigationLink(destination: GameDetailView(gameId: Int(game.gameId))) {
                            GameCellView(name: game.name,
                                         rating: game.rating,
                                         released: game.releasedDate,
                                         gameId: Int(game.gameId),
                                         backgroundImage: game.backgroundImage)
                        }

                    }
                    .onDelete(perform: deleteFavoriteGame)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Favorited Games")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: viewModel.getAllGames)
    }

    func deleteFavoriteGame(at offsets: IndexSet) {
        offsets.forEach { index in
            let favoriteGame = viewModel.games[index]
            viewModel.delete(favoriteGame)
        }
        viewModel.getAllGames()
    }
}
