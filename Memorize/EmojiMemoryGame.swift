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
    
    // MARK: - Access to the Model
    
    var cards: [StringMemoryGame.Card] { self.model.cards }
    
    private static func createMemoryGame() -> StringMemoryGame {
        let emojis = ["👻", "🎃", "🕷", "🤡", "💀"].shuffled()
        let randomNumber = Int.random(in: 2...emojis.count)
        return StringMemoryGame(numberOfPairsOfCards: randomNumber) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: - Intent(s)
    
    func choose(card: StringMemoryGame.Card) {
        self.model.choose(card: card)
    }
}
