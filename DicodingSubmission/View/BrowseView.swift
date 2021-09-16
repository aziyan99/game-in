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
                            HStack {
                                WebImage(url: URL(string: game.background_image))
                                    .resizable()
                                    .placeholder {
                                        RoundedRectangle(cornerRadius: 10.0).foregroundColor(Color(UIColor.lightGray))
                                    }
                                    .indicator(.activity)
                                    .frame(width: 60, height: 60)
                                    .scaledToFit()
                                    .cornerRadius(30)
                                VStack (alignment: .leading) {
                                    Text(game.name)
                                        .font(.body)
                                    Label("\(game.rating.clean)", systemImage: "star")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                NavigationLink(
                                    destination: GameDetailView(id: game.id),
                                    label: {
                                        Text("Details")
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                            .frame(width: 90, height: 35)
                                    })
                                    .background(colorScheme == .dark ? Color(UIColor.systemGray4) : Color.black)
                                    .cornerRadius(10.0)
                            }
                            .frame(width: geometry.size.width, alignment: .leading)
                            VStack {
                                Divider()
                                    .frame(width: (geometry.size.width / 12) * 10)
                            }.frame(width: geometry.size.width, alignment: .trailing)
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
