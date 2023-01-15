// FillingGapView.swift

import SwiftUI

struct FillingGapView: View {
    
    @State var splittedText: [TextPart]
    @State var fillingGap: FillingGap
    
    @State var texts: [String]
    @State var correct: Bool?
    
    init(fillingGap: FillingGap) {
        self._fillingGap = State(initialValue: fillingGap)
        
        let splittedText = fillingGap.text.split(separator: " ").map { TextPart(text: String($0)) }
        self._splittedText = State(initialValue: splittedText)
        
        let texts = Array(repeating: "", count: splittedText.count)
        self._texts = State(initialValue: texts)
    }
    
    var body: some View {
        VStack {
            CustomLayout {
                ForEach(Array(splittedText.enumerated()), id: \.offset) { index, part in
                    if part.text == "___" {
                        TextField("___", text: $texts[index])
                            .fixedSize(horizontal: true, vertical: false)
                            .disabled(correct != nil)
                            .autocorrectionDisabled()
                            .if(part.isCorrect != nil) {
                                $0.foregroundColor(part.isCorrect! ? .green : .red)
                            } else: {
                                $0.foregroundColor(.blue)
                            }
                            .onSubmit {
                                checkIfCorrect()
                            }
                    } else {
                        Text(part.text)
                    }
                }
            }
            
            CorrectView(correct: $correct)
        }
        .padding()
        
        Divider()
    }
    
    func checkIfCorrect() {
        var gapIndex = 0
        let splittedFillingText = fillingGap.text.split(separator: " ").map { String($0) }
        
        var resultText = splittedFillingText
        var rightText = splittedFillingText
        
        for (index, part) in splittedText.enumerated() {
            if part.text != "___" { continue }
            
            withAnimation {
                splittedText[index].isCorrect = texts[index] == fillingGap.gaps[gapIndex]
            }
            
            resultText[index] = texts[index]
            rightText[index] = fillingGap.gaps[gapIndex]
            
            gapIndex += 1
        }
        
        withAnimation {
            correct = rightText == resultText
        }
    }
}

struct FillingGapView_Previews: PreviewProvider {
    static var previews: some View {
        FillingGapView(fillingGap: FillingGap.exampleData.first!)
    }
}
