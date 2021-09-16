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
    @State var isShareSheetShowing: Bool = false
    
    
    init(id: Int) {
        self.id = id
        viewModel = GameDetailViewModel(id: self.id)
    }
    
    var body: some View {
        if viewModel.loading {
            VStack (alignment: .center) {
                ProgressView()
            }
        }
        else if viewModel.noConnection {
            Label("Lightning", systemImage: "bolt.fill")
        }
        else {
            GeometryReader { geometry in
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (alignment: .leading) {
                        Group {
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
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10.0)
                                Text(viewModel.developer_name)
                                    .font(.body)
                                Spacer()
                                Button(action: shareButton) {
                                    Image(systemName: "square.and.arrow.up")
                                }
                            }
                            
                            .padding([.bottom], 20)
                            
                            Text(viewModel.name)
                                .font(.title2)
                                .padding([.bottom], 20)
                            ExpandableTextView(viewModel.description_raw, lineLimit: 5)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.body)
                                .padding([.bottom], 30)
                        }
                        
                        Divider()
                        
                        Group {
                            Group {
                                Text("Information")
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
                                    Link(destination: URL(string: viewModel.website)!, label: {
                                        Text("Website")
                                    })
                                    Spacer()
                                    Link(destination: URL(string: viewModel.website)!, label: {
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
        }
    }
    
    func shareButton() {
        let url = URL(string: viewModel.website)
        let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(id: 1)
    }
}
