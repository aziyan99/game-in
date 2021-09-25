//
//  SearchView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 21/09/21.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @State var text: String
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        TextField("Search...", text: $text, onCommit: {
                            self.viewModel.fetchGames(searchText: text)
                        })
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 8)
                                    
                                    if isEditing {
                                        Button(action: {
                                            self.text = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                }
                            )
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                self.isEditing = true
                            }
                        
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.text = ""
                                self.viewModel.games = [Game]()
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                
                            }) {
                                Text("Cancel")
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                        }
                    }
                    
                    
                    if viewModel.loading {
                        ProgressView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    } else if viewModel.somethingWrong {
                        Label("Game not found", systemImage: "xmark.octagon")
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    } else if viewModel.loaded {
                        List {
                            ForEach (viewModel.games) { game in
                                NavigationLink(destination: GameDetailView(gameId: game.id)) {
                                    GameCellView(name: game.name,
                                                 rating: game.rating,
                                                 released: game.released,
                                                 id: game.id,
                                                 backgroundImage: game.background_image)
                                }
                                
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationBarTitle("Search")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
