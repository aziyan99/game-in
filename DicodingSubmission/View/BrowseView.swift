//
//  HighlightView.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 26/08/21.
//

import SwiftUI

struct BrowseView: View {
    
    @StateObject var viewModel = BrowseViewModel()
    
    var body: some View {
        NavigationView {
            List (viewModel.games) { game in
                Text(game.name)
            }
            .navigationTitle("Browse")
        }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
