//
//  DicodingSubmissionApp.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 26/08/21.
//

import SwiftUI

@main
struct DicodingSubmissionApp: App {
    @State var selectedMenu = 0
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedMenu) {
                GenreView()
                    .tabItem {
                        Label("Genre", systemImage: (selectedMenu == 0) ? "flag.fill" : "flag")
                    }.tag(0)
                BrowseView()
                    .tabItem {
                        Label("Browse", systemImage: (selectedMenu == 1) ? "square.grid.2x2.fill" : "square.grid.2x2")
                    }.tag(1)
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }.tag(1)
            }
        }
    }
}
