// LinePath.swift

import Foundation

// swiftlint:disable identifier_name
struct LinePath: Identifiable {
    var id = UUID()
    var variant: String
    var from: CGPoint
    var to: CGPoint
    var isCorrect = false
}
