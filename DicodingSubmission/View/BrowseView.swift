//
//  HighlightView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 26/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct BrowseView: View {
    
    @ObservedObject var viewModel = BrowseViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.loading {
                 ProgressView()
                }
                else if viewModel.failed {
                    Text("Failed to get data")
                }
                else if viewModel.loaded {
                    List (viewModel.games) { game in
                        NavigationLink(destination: GameDetailView()){
                            GameCellView(name: game.name, rating: game.rating, backgroundImage: game.background_image)
                        }
                    }.listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Browse")
        }
    }
}
    
    

struct GameCellView: View {
    
    let name: String
    let rating: Float
    let backgroundImage: String
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: backgroundImage)!)
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .scaledToFit()
                .frame(width: 100, alignment: .center)
                .cornerRadius(5.0)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.body)
                HStack {
                    Image(systemName: "star.fill")
                    Text("\(rating.clean)")
                        .font(.footnote)
                }
            }
        }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
