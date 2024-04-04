//
//  ContentView.swift
//  NCXlenavolkovs
//
//  Created by Elena Volkova on 26/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var spotifyManager = SpotifyManager()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(spotifyManager.items, id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text("\(item.artists[0].name) – \(item.album.name)")
                    }
            }
            .onChange(of: searchText) {
                    Task {
                        await spotifyManager.fetchSpotifyData(searchText: searchText)
                    }
            }
            .searchable(text: $searchText, prompt: "Search")
        }
//        .task {
//            await spotifyManager.fetchSpotifyData()
//        }
    }
}

#Preview {
    ContentView()
}
