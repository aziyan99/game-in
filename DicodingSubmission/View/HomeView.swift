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
            SearchView(text: "")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            FavoritedView()
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
            AboutView()
                .tabItem {
                    Label("About me", systemImage: "person.circle")
                }
        }
    }
}
