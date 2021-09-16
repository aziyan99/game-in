//
//  SettingView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            Image("ezzy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(30.0)
                .frame(width: 300, height: 300)
                .padding([.bottom], 20)
            
            Text("Hello I am Raja Azian, I am one of many dicoding student from Tanjungpinang. I really like coding stuff, and I have a dream to help others with my coding skills.")
                .padding([.bottom], 20)
            
            Button(action: {
                openURL(URL(string: "https://github.com/aziyan99")!)
            }, label: {
                Label(
                    title: { Text("Visit my Github") },
                    icon: { Image(systemName: "link") }
                )
                .font(.body)
                .foregroundColor(.white)
                .frame(width: 300, height: 35)
            })
            .background(colorScheme == .dark ? Color(UIColor.systemGray4) : Color.black)
            .cornerRadius(10.0)
            
        }.padding()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
