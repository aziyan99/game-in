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
    let gameId: Int
    let backgroundImage: String

    var body: some View {
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
        }
    }
}
