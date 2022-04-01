//
//  ContentView.swift
//  BadSelEmojiSample
//
//  Created by Christopher Camacho on 31/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: FrameSettings(modelData: ModelData())) {
                Spacer(); Text(verbatim: "Frame settings").padding().foregroundColor(.blue); Text(">").foregroundColor(.blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
