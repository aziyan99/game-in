//
//  GameDetailView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailView: View {
    
    let id: Int
    @ObservedObject var viewModel: GameDetailViewModel
    @Environment(\.openURL) var openURL

    
    init(id: Int) {
        self.id = id
        viewModel = GameDetailViewModel(id: self.id)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView (.vertical, showsIndicators: false) {
                VStack (alignment: .leading) {
                    WebImage(url: URL(string: viewModel.background_image))
                        .resizable()
                        .placeholder {
                            RoundedRectangle(cornerRadius: 10.0).foregroundColor(Color(UIColor.lightGray))
                        }
                        .indicator(.activity)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 200)
                        .cornerRadius(10.0)
                    
                    HStack (alignment: .center) {
                        WebImage(url: URL(string: viewModel.developer_image_background))
                            .resizable()
                            .placeholder {
                                RoundedRectangle(cornerRadius: 10.0).foregroundColor(Color(UIColor.lightGray))
                            }
                            .indicator(.activity)
                            .frame(width: 40, height: 40)
                            .cornerRadius(10.0)
                        Text(viewModel.developer_name)
                            .font(.body)
                    }
                    .padding([.bottom], 20)
                    
                    Text(viewModel.name)
                        .font(.title2)
                        .padding([.bottom], 20)
                    ExpandableTextView(viewModel.description_raw, lineLimit: 5)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.body)
                        .padding([.bottom], 30)
                    
                    VStack (alignment: .center) {
                        Button(action: {
                            openURL(URL(string: viewModel.website)!)
                        }, label: {
                            Text("\(viewModel.name) Website")
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width, height: 35)
                            
                        })
                        .background(Color.black)
                        .cornerRadius(10.0)
                        Spacer()
                        Button(action: {
                            openURL(URL(string: viewModel.redditUrl)!)
                        }, label: {
                            Text("\(viewModel.name) Reddit")
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width, height: 35)
                        })
                        .background(Color.black)
                        .cornerRadius(10.0)
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
        .padding([.leading, .trailing])
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(id: 1)
    }
}
