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
                BrowseView()
                    .tabItem {
                        Label("Browse", systemImage: (selectedMenu == 0) ? "square.grid.2x2.fill" : "square.grid.2x2")
                    }.tag(0)
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }.tag(1)
            }
        }
    }
}
