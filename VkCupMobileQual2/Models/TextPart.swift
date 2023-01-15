// TextPart.swift

import Foundation

struct TextPart: Identifiable {
    var id = UUID()
    var text: String
    var isAdded = false
    var isCorrect: Bool?
}
