//
//  ContentView.swift
//  MemoryGame
//
//  Created by student on 17/10/2023.
//

import SwiftUI

struct ContentView: View {
    let themes: [(name: String, icons: [String], backgroundColor: Color, pairs: Int)] = [
        ("Animals", ["🐨", "🦊", "🐯", "🦁", "🐻‍❄️", "🐼", "🐸", "🐔"], .yellow, 4),
        ("Fruits", ["🍎", "🍇", "🍌", "🍉", "🍓", "🍍", "🥥", "🍒"], .green, 5),
        ("Sports", ["⚽", "🏀", "🎾", "🏈", "🏓", "🏸", "🏊", "🚴"], .blue, 6)
    ]

    
    @State private var selectedThemeIndex = 0
        @State private var cardViews: [CardView] = []
        
    var themeButtons: some View {
        HStack {
            ForEach(themes.indices, id: \.self) { index in
                ThemeButtonView(
                    themeName: themes[index].name,
                    isSelected: index == selectedThemeIndex,
                    action: {
                        selectedThemeIndex = index
                        shuffleCards()
                    }
                )
            }
        }
    }
    
    @State var Cards: Array<CardView> = []
    func shuffleCards() {
        let theme = themes[selectedThemeIndex]
        let shuffledIcons = Array((theme.icons + theme.icons).shuffled().prefix(theme.pairs))
        
        Cards = shuffledIcons.map { icon in
            CardView(item: icon)
        }
    }
    
    
    var icons = ["🐨","🦊","🐯","🦁","🐻‍❄️","🐼","🐸","🐔"]
    @State private var cardCount = 6
    @State var CardNumber: Int = 6
    
    var column = [GridItem(.flexible(minimum: 120), spacing: 10),
                  GridItem(.flexible(minimum: 50), spacing: 10)]
    var cardDelete: some View {
        cardAdjustmentButton(offset: -2, symbol: "-")
    }
    var cardAdd: some View {
        cardAdjustmentButton(offset: 2, symbol: "+")
    }
    
    var cardDisplay: some View {
            ScrollView {
                LazyVGrid(columns: column, content: {
                                      ForEach(0..<CardNumber, id:\.self) { i in
                        
                        
                        let random = icons.randomElement()
                        CardView(item: random!)
                    }
                })
                .foregroundColor(.blue)
                .padding(12)
            }
        }
    
    func ClearCards()
    {
        Cards.removeAll()
    }
    
    var body: some View {
        VStack {
            Text("Memo")
                .font(.largeTitle)
            themeButtons
            cardDisplay
        }.onAppear {
            shuffleCards()
        }

        HStack {
            cardDelete
            Spacer()
            cardAdd
        }
        .padding(.horizontal, 20)
    }
    
    
    func cardAdjustmentButton(offset: Int, symbol: String) -> some View {
            var isEnabled = true
        
            if(offset < 0)
            {
                isEnabled = CardNumber > 2
            }
            
            return Button( action: {
                if isEnabled {
                    CardNumber += offset
                }
            }) {
                if isEnabled {
                    Text(symbol)
                        .font(.title)
                } else {
                    Text(symbol)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .disabled(!isEnabled)
            .frame(width: 80, height: 40)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(isEnabled ? Color.blue : Color.gray, lineWidth: 2)
                    }
                )
        }

    
}



#Preview {
    ContentView()
}
