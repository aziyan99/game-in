//
//  HomeView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 04/09/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "doc.plaintext")
                }
            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gearshape")
                }
        }.accentColor(.black)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
