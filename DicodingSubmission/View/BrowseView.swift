//
//  BrowseView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct BrowseView: View {
    
    @ObservedObject var viewModel = GameViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            
            if viewModel.loading {
                VStack (alignment: .center) {
                    ProgressView()
                }
            }
            else if viewModel.noConnection {
                Label("No internet connection", systemImage: "wifi.exclamationmark")
            }
            else if viewModel.somethingWrong {
                Label("Failed to load data", systemImage: "xmark.octagon")
            }
            else {
                GeometryReader { geometry in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack (alignment: .leading) {
                            Text(viewModel.currentDate)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            Text("Today Picks")
                                .font(.title)
                        }.frame(width: geometry.size.width, alignment: .leading)
                        
                        ForEach (viewModel.games) { game in
                            GameCellView(name: game.name, rating: game.rating, released: game.released, id: game.id, backgroundImage: game.background_image)
                        }
                        
                    }
                }
                .padding([.top, .leading, .trailing])
                .navigationBarHidden(true)
            }
        }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
