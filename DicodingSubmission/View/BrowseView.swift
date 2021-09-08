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
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack (alignment: .leading) {
                        Text("SATURDAY 4 SEPTEMBER")
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
                                destination: GameDetailView(),
                                label: {
                                    Text("Details")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .frame(width: 90, height: 35)
                                })
                                .background(Color.black)
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

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
