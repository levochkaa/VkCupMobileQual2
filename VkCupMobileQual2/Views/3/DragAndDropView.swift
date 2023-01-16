// DragAndDropView.swift

import SwiftUI

struct DragAndDropView: View {
    
    @State var splittedText: [TextPart]
    @State var dragAndDrop: DragAndDrop
    
    @State var correct: Bool?
    
    init(dragAndDrop: DragAndDrop) {
        self._dragAndDrop = State(initialValue: dragAndDrop)
        
        let splittedText = dragAndDrop.text.split(separator: " ").map { TextPart(text: String($0)) }
        self._splittedText = State(initialValue: splittedText)
    }
    
    var body: some View {
        VStack {
            CustomLayout {
                ForEach(Array(splittedText.enumerated()), id: \.offset) { index, part in
                    Group {
                        if part.isAdded && part.isCorrect != nil {
                            Text(part.text)
                                .foregroundColor(part.isCorrect! ? .green : .red)
                        } else if part.isAdded && part.isCorrect == nil {
                            Text(part.text)
                                .foregroundColor(.blue)
                        } else {
                            Text(part.text)
                        }
                    }
                    .transition(.scale)
                    .if(part.text == "___") {
                        $0.dropDestination(for: String.self) { items, _ in
                            guard let firstItem = items.first else { return false }
                            
                            replaceText(for: index, with: firstItem)
                            
                            return true
                        }
                    }
                }
            }
            
            CustomLayout {
                ForEach(dragAndDrop.variants, id: \.self) { variant in
                    Text(variant)
                        .padding(5)
                        .draggable(variant)
                        .transition(.scale)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                        }
                }
            }
            
            CorrectView(correct: $correct)
        }
        .padding()
        
        Divider()
    }
    
    func replaceText(for index: Int, with text: String) {
        guard let indexToRemove = dragAndDrop.variants.firstIndex(of: text) else { return }
        
        withAnimation {
            splittedText[index] = TextPart(text: text, isAdded: true)
            dragAndDrop.variants.remove(at: indexToRemove)
        }
        
        if splittedText.contains(where: { $0.text == "___" }) { return }
        
        var gapIndex = 0
        var rightText = dragAndDrop.text.split(separator: " ").map { String($0) }
        
        for (index, part) in rightText.enumerated() where part == "___" {
            rightText[index] = dragAndDrop.gaps[gapIndex]
            gapIndex += 1
        }
        
        for index in 0..<splittedText.count {
            withAnimation {
                splittedText[index].isCorrect = rightText[index] == splittedText[index].text
            }
        }
        
        let rightTextString = rightText.joined(separator: " ")
        let resultText = splittedText.map { $0.text }.joined(separator: " ")
        
        withAnimation {
            correct = rightTextString == resultText
        }
    }
}
