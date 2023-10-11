//
//  MemoryGame.swift
//  Memorize
//
//  Created by smaung on 20/8/2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var faceUpCardIdx: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly}
        set { cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    init(numPairsCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIdx in 0..<numPairsCards {
            cards.append(Card(content: createCardContent(pairIdx), id: pairIdx*2))
            cards.append(Card(content: createCardContent(pairIdx), id: pairIdx*2+1))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIdx = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIdx].isFaceUp,
           !cards[chosenIdx].isMatched {
            if let matchIdx = faceUpCardIdx {
                if cards[chosenIdx].content == cards[matchIdx].content {
                    cards[matchIdx].isMatched = true
                    cards[chosenIdx].isMatched = true
                }
                cards[chosenIdx].isFaceUp = true
            } else {
                faceUpCardIdx = chosenIdx
            }
        }
    }
    
    
    struct Card: Identifiable {
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
