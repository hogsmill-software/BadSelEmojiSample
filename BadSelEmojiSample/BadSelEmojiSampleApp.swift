//
//  BadSelEmojiSampleApp.swift
//  BadSelEmojiSample
//
//  Created by Christopher Camacho on 31/03/2022.
//

import SwiftUI

@main
struct BadSelEmojiSampleApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
