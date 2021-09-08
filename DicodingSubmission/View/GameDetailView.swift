//
//  GameDetailView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

import SwiftUI

struct GameDetailView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack (alignment: .leading) {
                    Image("sample")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 200)
                        .cornerRadius(10.0)
                    HStack (alignment: .center) {
                        Image("ezzy-pixel")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Rockstar.inc")
                            .font(.body)
                    }
                    .padding([.bottom], 20)
                    Text("Grand Theft Auto: V")
                        .font(.title2)
                        .padding([.bottom], 20)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacinia id tempor, faucibus nullam. Congue porta justo vitae suspendisse fusce egestas et scelerisque amet. Mattis mattis et enim faucibus rhoncus. In fusce pulvinar consequat dictum egestas purus hendrerit sollicitudin ut. Ut ultrices phasellus mauris amet. Est cras viverra egestas cursus penatibus massa sed. Pellentesque et ullamcorper gravida molestie in lobortis. Commodo orci, mauris cras ultricies interdum vitae id. Quam augue mauris sit in sed quam. Justo semper et, neque, adipiscing scelerisque cursus ut nulla. Vitae odio cursus vestibulum pellentesque volutpat elementum. Lorem suspendisse ornare hendrerit vivamus viverra ullamcorper at. Mi phasellus sit est viverra congue pellentesque sapien")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.body)
                        .padding([.bottom], 30)
                    VStack (alignment: .center) {
                        Button(action: {
                            
                        }, label: {
                            Text("GTA 5 Website")
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width, height: 35)
                            
                        })
                        .background(Color.black)
                        .cornerRadius(10.0)
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("GTA 5 Reddit")
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width, height: 35)
                        })
                        .background(Color.black)
                        .cornerRadius(10.0)
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("GTA 5 Metacritic")
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width, height: 35)
                        })
                        .background(Color.black)
                        .cornerRadius(10.0)
                        Spacer()
                    }.frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width)
            }
        }
        .padding([.leading, .trailing])
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView()
    }
}
