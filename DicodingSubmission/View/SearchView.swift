    //
    //  SearchView.swift
    //  DicodingSubmission
    //
    //  Created by Raja Azian on 21/09/21.
    //
    
    import SwiftUI
    
    struct SearchView: View {
        @State var searchText: String = ""
        @State private var isEditing = false
        @ObservedObject var viewModel = SearchViewModel()
        
        var body: some View {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            HStack {
                                TextField("Search....", text: $searchText)
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
                                                    self.searchText = ""
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
                                    .onChange(of: searchText) {
                                        viewModel.fetchGames(searchText: "\($0)")
                                        print(viewModel.games)
                                    }
                                
                                if isEditing {
                                    Button(action: {
                                        self.isEditing = false
                                        self.searchText = ""
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
                            }
                            else if viewModel.somethingWrong {
                                Label("Failed to load data", systemImage: "xmark.octagon")
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                            }
                            else if viewModel.loaded {
                                ForEach(viewModel.games) { game in
                                    GameCellView(name: game.name, rating: game.rating, released: game.released, id: game.id, backgroundImage: game.background_image)
                                }
                            }
                        }
                    }
                }
                .navigationTitle(Text("Search"))
            }
        }
    }
    
    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            SearchView(searchText: "")
        }
    }
