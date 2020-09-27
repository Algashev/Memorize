//
//  MemoryGame.swift
//  Memorize
//
//  Created by Александр Алгашев on 12.09.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import Foundation

typealias StringMemoryGame = MemoryGame<String>

struct MemoryGame<CardContent: Equatable> {
    struct Card: Identifiable {
        var id: Int
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
    
    var cards: [Card]
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { self.cards.indices.filter { self.cards[$0].isFaceUp }.only }
        set {
            for index in self.cards.indices {
                self.cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            self.cards.append(Card(id: pairIndex * 2, content: content))
            self.cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
    }
    
    mutating func choose(card: Card) {
        guard
            let chosenCardIndex = self.cards.firstIndex(matching: card),
            !self.cards[chosenCardIndex].isFaceUp,
            !self.cards[chosenCardIndex].isMatched
        else { return }
        
        if let potentialMatchIndex = self.indexOfTheOneAndOnlyFaceUpCard {
            if self.cards[chosenCardIndex].content == self.cards[potentialMatchIndex].content {
                self.cards[chosenCardIndex].isMatched = true
                self.cards[potentialMatchIndex].isMatched = true
            }
            self.cards[chosenCardIndex].isFaceUp = true
        } else {
            self.indexOfTheOneAndOnlyFaceUpCard = chosenCardIndex
        }
    }
}
