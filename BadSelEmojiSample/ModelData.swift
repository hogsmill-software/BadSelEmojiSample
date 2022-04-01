//
//  ModelData.swift
//  BadSelEmojiSample
//
//  Created by Christopher Camacho on 31/03/2022.
//

import Foundation


final class ModelData: ObservableObject {
    @Published var selectedSymbol: String
    @Published var selectedEmoji: String
    @Published var useEmoji: Bool
    
    init() {
        selectedSymbol = "♥"
        selectedEmoji = "♥️"
        useEmoji = false
    }
    
}
