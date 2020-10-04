//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Александр Алгашев on 11.09.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(self.viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                self.viewModel.choose(card: card)
            }.padding(5)
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    // MARK: - Drawing Constants
    
    private let fontScale: CGFloat = 0.75
    
    let card: StringMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if self.card.isFaceUp || !self.card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90)).padding(5).opacity(0.4)
                Text(self.card.content).font(.system(size: self.fontSize(for: size)))
            }.cardify(isFaceUp: self.card.isFaceUp)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.height, size.width) * self.fontScale
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards.first)
        return EmojiMemoryGameView(viewModel: game)
    }
}
