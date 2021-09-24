//
//  GameCellView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 21/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCellView: View {
    let name: String
    let rating: Float
    let released: String
    let id: Int
    let backgroundImage: String

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
//        GeometryReader { geometry in
            HStack {
                WebImage(url: URL(string: backgroundImage))
                    .resizable()
                    .placeholder {
                        RoundedRectangle(cornerRadius: 10.0).foregroundColor(Color(UIColor.lightGray))
                    }
                    .indicator(.activity)
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .cornerRadius(30)
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.body)
                    HStack {
                        Label("\(rating.clean)", systemImage: "star")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Label("\(released)", systemImage: "calendar")
                            .font(.footnote)
                            .foregroundColor(.secondary)

                    }
                }
//                Spacer()
//                NavigationLink(
//                    destination: GameDetailView(gameId: id),
//                    label: {
//                        Text("Details")
//                            .font(.footnote)
//                            .foregroundColor(.white)
//                            .frame(width: 90, height: 35)
//                    })
//                    .background(colorScheme == .dark ? Color(UIColor.systemGray4) : Color.black)
//                    .cornerRadius(10.0)
            }
//            .frame(width: geometry.size.width, alignment: .leading)
//            VStack {
//                Divider()
//                    .frame(width: (geometry.size.width / 12) * 10)
//            }.frame(width: geometry.size.width, alignment: .trailing)
//        }
//        .padding([.bottom], 58)
    }
}
