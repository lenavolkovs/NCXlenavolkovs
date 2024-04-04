//
//  NCXlenavolkovsApp.swift
//  NCXlenavolkovs
//
//  Created by Elena Volkova on 26/03/24.
//

import SwiftUI

@main
struct NCXlenavolkovsApp: App {
    
    @StateObject var spotifyManager = SpotifyManager()
    
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
    }
}
