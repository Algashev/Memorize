//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Александр Алгашев on 12.09.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    private static let emojis = ["👻", "🎃", "🕷"]
    
    // MARK: - Access to the Model
    
    var cards: [StringMemoryGame.Card] { self.model.cards }
    
    private static func createMemoryGame() -> StringMemoryGame {
        StringMemoryGame(numberOfPairsOfCards: EmojiMemoryGame.emojis.count) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    // MARK: - Intent(s)
    
    func choose(card: StringMemoryGame.Card?) {
        self.model.choose(card: card)
    }
    
    func resetGame() {
        self.model = EmojiMemoryGame.createMemoryGame()
    }
}
