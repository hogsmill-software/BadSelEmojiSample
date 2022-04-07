//
//  FrameSettings.swift
//  BadSelEmojiSample
//
//  Created by Christopher Camacho on 31/03/2022.
//

import SwiftUI

struct FrameSettings: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var selectedSymbol: String
    @State private var selectedEmoji: String

    @State private var symbolListPopOver = false
    @State private var emojiListPopOver = false
    
    
    private var availableSymbols = [["■", "▲", "●", "☻", "♠", "♣", "♥", "♦"],
                                       ["★", "✪", "⍟", "⎈", "❉", "❋", "✺", "✹"],
                                       ["✸", "✶", "✷", "✵", "✲", "✱", "✦", "⊛"],
                                       ["⁕", "❃", "❂", "✼", "⨳", "✚", "❖", "✜"]]
    
    private var availableEmojis = [["❤️", "🧡", "💛", "💚", "💙", "💜"],
                                  ["🖤", "🤍", "🤎", "💔", "💌", "💕"],
                                  ["💞", "💓", "💗", "💖", "💘", "💝"],
                                  ["💟", "🔴", "🟠", "🟡", "🟢", "🔵"],
                                  ["🟣", "⚫️", "⚪️", "🟤", "🔺", "🔸"],
                                  ["🔹", "🔶", "🔷", "🟥", "🟧", "🟨"],
                                  ["🟩", "🟦", "🟪", "⬛️", "⬜️", "🟫"],
                                  ["♠️", "♣️", "♥️", "♦️", "💧", "🩸"],
                                  ["⭐️", "🌟", "✨", "💥", "🔥", "☀️"]]
    
    private let veryLightBlue = Color(red: 0.90, green: 0.90, blue: 1.00)
    private let lightGrey = Color(red: 0.90, green: 0.90, blue: 0.90)
    
    
    init(modelData:  ModelData) {
        _selectedEmoji = State(wrappedValue: modelData.selectedEmoji)
        _selectedSymbol = State(wrappedValue: modelData.selectedSymbol)
    }
    
    func selectEmoji(row: Int, column: Int) {
        modelData.selectedEmoji = availableEmojis[row][column]
        selectedEmoji = modelData.selectedEmoji
        emojiListPopOver = false
    }
    
    func selectSymbol(row: Int, column: Int) {
        modelData.selectedSymbol = availableSymbols[row][column]
        selectedSymbol = modelData.selectedSymbol
        symbolListPopOver = false
    }
    
    var body: some View {
        
        let useEmoji = modelData.useEmoji
        let leftEmojiTitleColor =  (useEmoji) ?  Color.black : Color.gray
        let leftSymbolTitleColor =  (useEmoji) ? Color.gray : Color.black
        
        let emojiCtrlBorderColor =  (useEmoji) ?  Color.blue : Color.gray
        let symbolCtrlBorderColor =  (useEmoji) ? Color.gray : Color.blue
        
        let emojiCtrlBackgroundColor =  (useEmoji) ?  Color.white : lightGrey
        let symbolCtrlBackgroundColor =  (useEmoji) ? lightGrey : Color.white
        
        let emojiOpacity = (useEmoji) ? 1 : 0.5

        VStack {
            Toggle("Use emoji", isOn: $modelData.useEmoji)
        
            HStack {
                Text("Emoji").foregroundColor(leftEmojiTitleColor)
                Spacer()
                Button(action: { if (useEmoji) { emojiListPopOver = true } } ) {
                    Text(selectedEmoji).padding(.leading, 3)
                        .padding(.trailing, 3)
                        .padding(.top, 3)
                        .padding(.bottom, 3)
                        .opacity(emojiOpacity)
                    }
                // Line below is important. Without it, if you press "< Back" and return to this screen, selection appears to be lost (but previously selected item shows in pop up)
                .onAppear(perform: {selectedEmoji = modelData.selectedEmoji})
                .popover(isPresented: $emojiListPopOver,
                        attachmentAnchor: .point(.bottom),
                        arrowEdge: .bottom) {
                                    VStack {
                        Spacer()
                        Text("Select an emoji for frame edge").padding(.top)
                        Spacer()
                                        
                        ForEach(0 ..< 9) { j in
                             HStack {
                                 ForEach(0 ..< 6) {
                                     let i = $0
                                     let currentEmoji = availableEmojis[j][i]
                                     let borderColor = (modelData.selectedEmoji == currentEmoji) ? Color.blue : Color.white
                                     let backgroundColor = (modelData.selectedEmoji == currentEmoji) ? veryLightBlue : Color.white
                                    
                                    Text(String(currentEmoji))
                                         .onTapGesture { selectEmoji(row: j, column: i) }
                                         .padding(4)
                                             .border(borderColor)
                                             .background(backgroundColor)
                                         }
                                     .frame(width: 30, height: 30, alignment: .center)
                                 }
                             }
                            
                        Spacer()
                        }
                        }
                    .buttonStyle(PlainButtonStyle())
                    .border(emojiCtrlBorderColor)
                    .background(emojiCtrlBackgroundColor)
            }

            HStack {
                Text("Symbol").foregroundColor(leftSymbolTitleColor)
                Spacer()
                Button(action: { if (!useEmoji) { symbolListPopOver = true }} ) {
                        Text(selectedSymbol).padding(.leading, 6)
                        .padding(.trailing, 6)
                        .padding(.top, 3)
                        .padding(.bottom, 3)
                        .foregroundColor(symbolCtrlBorderColor)
                    }
                // Line below is important. Without it, if you press "< Back" and return to this screen, selection appears to be lost (but previously selected item shows in pop up)
                .onAppear(perform: { selectedSymbol = modelData.selectedSymbol })
                .popover(isPresented: $symbolListPopOver,
                        attachmentAnchor: .point(.bottom),
                        arrowEdge: .bottom) {
                                    VStack {
                        Spacer()
                        Text("Select a character for frame edge").padding(.top)
                        Spacer()
                                        
                        ForEach(0 ..< 4) { j in
                             HStack {
                                 ForEach(0 ..< 8) {
                                     let i = $0
                                     let currentChr = availableSymbols[j][i]
                                     let symbolColor =  (modelData.selectedSymbol == currentChr) ? Color.blue : Color.gray
                                     let borderColor = (modelData.selectedSymbol == currentChr) ? Color.blue : Color.white
                                     let backgroundColor = (modelData.selectedSymbol == currentChr) ? veryLightBlue : Color.white
                                    
                                    Text(String(currentChr))
                                         .onTapGesture { selectSymbol(row: j, column: i) }
                                         .padding(4)
                                             .foregroundColor(symbolColor)
                                             .border(borderColor)
                                             .background(backgroundColor)
                                         }
                                     .frame(width: 25, height: 25, alignment: .center)
                                 }
                             }
                            
                        Spacer()
                        }
                        }
                    .buttonStyle(PlainButtonStyle())
                    .border(symbolCtrlBorderColor)
                    .background(symbolCtrlBackgroundColor)
            }
        }
    }
}

struct FrameSettings_Previews: PreviewProvider {
    static var previews: some View {
        FrameSettings(modelData: ModelData())
    }
}

