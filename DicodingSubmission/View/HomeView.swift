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
            SearchView(searchText: "")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            AboutView()
                .tabItem {
                    Label("About me", systemImage: "person.circle")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
