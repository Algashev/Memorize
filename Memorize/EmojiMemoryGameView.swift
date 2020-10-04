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
    
    let resetGameAnumationDuration: Double = 1
    let flipAnimationDuration: Double = 0.75
    
    var grid: some View {
        Grid(self.viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                withAnimation(.linear(duration: self.flipAnimationDuration)) {
                    self.viewModel.choose(card: card)
                }
            }.padding(5)
        }
        .padding()
    }
    
    var body: some View {
        VStack {
            self.grid
            Button() {
                withAnimation(.easeInOut(duration: self.resetGameAnumationDuration)) {
                    self.viewModel.resetGame()
                }
            } label: { Text("New Game") }
        }.foregroundColor(.orange)
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
    
    private var animatedPie: some View {
        Group {
            if self.card.isConsumingBonusTime {
                self.pie(withEndAnglePercent: self.animatedBonusRemaning)
                    .onAppear {
                        self.startBonusTimeAnimation()
                    }
            } else {
                self.pie(withEndAnglePercent: self.card.bonusRemaining)
            }
        }
    }
    
    @State private var animatedBonusRemaning: Double = 0
    
    private func startBonusTimeAnimation() {
        self.animatedBonusRemaning = self.card.bonusRemaining
        withAnimation(.linear(duration: self.card.bonusTimeRemaining)) {
            self.animatedBonusRemaning = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if self.card.isFaceUp || !self.card.isMatched {
            ZStack {
                self.animatedPie
                .padding(5)
                .opacity(0.4)
                Text(self.card.content)
                    .font(.system(size: self.fontSize(for: size)))
                    .rotationEffect(Angle.degrees(self.card.isMatched ? 360 : 0))
                    .animation(self.card.isMatched ?  Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: self.card.isFaceUp)
            .transition(.scale)
        }
    }
    
    private func pie(withEndAnglePercent endAnglePercent: Double) -> some View {
        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-endAnglePercent * 360 - 90))
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
