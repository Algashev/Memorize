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
    private(set) var cards: [Card]
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
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
        self.cards.shuffle()
    }
    
    mutating func choose(card: Card?) {
        guard
            let card = card,
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

// MARK: - Card

extension MemoryGame {
    struct Card: Identifiable {
        var id: Int
        var isFaceUp = false {
            didSet {
                if self.isFaceUp {
                    self.startUsingBonusTime()
                } else {
                    self.stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet { self.stopUsingBonusTime() }
        }
        var content: CardContent
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user mathces the card
        // before a certain amount of time passes during the card is face up
        
        // can be zero which means *no bonus available* for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return self.pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return self.pastFaceUpTime
            }
        }
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, self.bonusTimeLimit - self.faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            if self.bonusTimeLimit > 0 && self.bonusTimeRemaining > 0 {
                return self.bonusTimeRemaining / self.bonusTimeLimit
            }
            return 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            self.isMatched && self.bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmathced and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            self.isFaceUp && !self.isMatched && self.bonusTimeRemaining > 0
        }
        
        // called when the card transition to face up state
        private mutating func startUsingBonusTime() {
            if self.isConsumingBonusTime, self.lastFaceUpDate == nil {
                self.lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            self.pastFaceUpTime = self.faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
