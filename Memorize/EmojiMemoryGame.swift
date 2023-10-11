//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by smaung on 21/8/2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = [
        "🚀", "🛺", "🚝", "🚎",
        "🚗", "🛻", "🚛", "🚑",
        "🛴", "✈️", "🚲", "🚤",
        "🏍️", "🚔", "🚔", "🏎️",
        "🛵", "🚋", "🚜", "🚢",
        "🚒", "🚉", "🚁", "🚠"
    ]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>( numPairsCards: 8 ) { pairIdx in EmojiMemoryGame.emojis[pairIdx] }
    }

    @Published
    private(set) var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
}
