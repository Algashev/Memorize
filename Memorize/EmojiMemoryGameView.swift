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
        HStack {
            ForEach(self.viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    let fontScale: CGFloat = 0.75
    let aspectRatio: CGFloat = 2 / 3
    
    let card: StringMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    var cardRectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: self.cornerRadius)
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                self.cardRectangle.fill(Color.white)
                self.cardRectangle.stroke(lineWidth: self.edgeLineWidth)
                Text(self.card.content)
            } else {
                self.cardRectangle.fill()
            }
        }
        .font(.system(size: self.fontSize(for: size)))
        .aspectRatio(self.aspectRatio, contentMode: .fit)
    }
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.height, size.width) * self.fontScale
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
