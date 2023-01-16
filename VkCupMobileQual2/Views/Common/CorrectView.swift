// CorrectView.swift

import SwiftUI

struct CorrectView: View {
    
    @Binding var correct: Bool?
    
    var body: some View {
        Group {
            if let correct {
                if correct {
                    Label("Correct", systemImage: "checkmark")
                        .foregroundColor(.green)
                } else {
                    Label("Nope", systemImage: "xmark")
                        .foregroundColor(.red)
                }
            }
        }
        .transition(.scale.combined(with: .opacity))
    }
}

