//
//  MemoryGame.swift
//  Memorize
//
//  Created by Александр Алгашев on 12.09.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import Foundation

typealias StringMemoryGame = MemoryGame<String>

struct MemoryGame<CardContent> {
    struct Card: Identifiable {
        var id: Int
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
    }
    
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            self.cards.append(Card(id: pairIndex * 2, content: content))
            self.cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenCardIndex = self.index(of: card) ?? 0
        self.cards[chosenCardIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int? {
        self.cards.firstIndex { $0.id == card.id }
    }
}
