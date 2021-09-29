//
//  GameDetailView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailView: View {

    let gameId: Int
    @ObservedObject var viewModel: GameDetailViewModel
    @State var isShareSheetShowing: Bool = false
    let defaultUrl = URL(string: "https://rawg.io")
    @State var favoritedImage = "heart"

    init(gameId: Int) {
        self.gameId = gameId
        viewModel = GameDetailViewModel(gameId: self.gameId)
    }

    var body: some View {
        if viewModel.loading {
            VStack(alignment: .center) {
                ProgressView()
            }
        } else if viewModel.noConnection {
            Label("No internet connection", systemImage: "wifi.exclamationmark")
        } else if viewModel.somethingWrong {
            Label("Failed to load data", systemImage: "xmark.octagon")
        } else {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Group {
                            WebImage(url: URL(string: viewModel.backgroundImage))
                                .resizable()
                                .placeholder {
                                    RoundedRectangle(cornerRadius: 10.0).foregroundColor(Color(UIColor.lightGray))
                                }
                                .indicator(.activity)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 200)
                                .cornerRadius(10.0)
                                .padding([.top], 10)

                            HStack(alignment: .center) {
                                WebImage(url: URL(string: viewModel.developerImageBackground))
                                    .resizable()
                                    .placeholder {
                                        RoundedRectangle(cornerRadius: 10.0).foregroundColor(Color(UIColor.lightGray))
                                    }
                                    .indicator(.activity)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10.0)
                                Text(viewModel.developerName)
                                    .font(.body)
                                Spacer()
                                Button(action: {
                                    if self.favoritedImage == "heart" {
                                        self.favoritedImage = "heart.fill"
                                    } else {
                                        self.favoritedImage = "heart"
                                    }
                                }, label: {
                                    Image(systemName: "\(self.favoritedImage)")
                                })
                                Button(action: shareButton) {
                                    Image(systemName: "square.and.arrow.up")
                                }
                            }
                            .padding([.bottom], 20)

                            Text(viewModel.name)
                                .font(.title2)
                                .padding([.bottom], 20)
                            ExpandableTextView(viewModel.descriptionRaw, lineLimit: 5)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.body)
                                .padding([.bottom], 30)
                        }

                        Divider()

                        Group {
                            Group {
                                Text("Information")
                                    .bold()
                                    .font(.title2)
                                    .padding([.bottom], 10)

                                Spacer()
                                HStack {
                                    Text("Released")
                                    Spacer()
                                    Text(viewModel.released)
                                }
                                Divider()

                                HStack {
                                    Text("Updated")
                                    Spacer()
                                    Text(viewModel.updated)
                                }
                                Divider()
                                VStack(alignment: .leading) {
                                    Text("Minimum PC Requirements")
                                        .padding([.bottom], 5)
                                    Spacer()
                                    ExpandableTextView(viewModel.minimumPcRequirement, lineLimit: 5)
                                        .font(.body)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                Divider()

                                VStack(alignment: .leading) {
                                    Text("Recommended PC Requirements")
                                        .padding([.bottom], 5)
                                    Spacer()
                                    ExpandableTextView(viewModel.recommendedPcRequirement, lineLimit: 5)
                                        .font(.body)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                Divider()
                            }
                            Group {
                                HStack {
                                    Link(destination: URL(string: viewModel.website) ?? defaultUrl!, label: {
                                        Text("Website")
                                    })
                                    Spacer()
                                    Link(destination: URL(string: viewModel.website) ?? defaultUrl!, label: {
                                        Image(systemName: "safari")
                                    })
                                }
                                .foregroundColor(.blue)
                                Divider()
                            }
                        }
                    }
                    .padding([.bottom], 20)
                }
            }
            .padding([.leading, .trailing])
            .navigationBarTitle(Text(viewModel.name), displayMode: .inline)
        }
    }

    func shareButton() {
        var shareAction: UIActivityViewController
        let url = URL(string: viewModel.website)
        shareAction = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(shareAction, animated: true, completion: nil)
    }
}
