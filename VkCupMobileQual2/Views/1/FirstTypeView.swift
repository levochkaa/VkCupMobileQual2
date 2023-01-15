// FirstTypeView.swift

import SwiftUI

struct FirstTypeView: View {
    
    @State var data = Questions.exampleData
    @State var addingQuestions = false
    
    var body: some View {
        OffsetScrollView(navigationTitle: "Questions", horizontalAlignment: .leading) {
            ForEach(data) { questions in
                questionsView(from: questions.questions)
            }
        } onOffsetChange: { value in
            if addingQuestions { return }
            
            let maxY = Int(value.maxY)
            if maxY < 1000 {
                addQuestions()
            }
        }
    }
    
    @ViewBuilder func questionsView(from questions: [Question]) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(Array(questions.enumerated()), id: \.offset) { index, question in
                QuestionView(question: question, questionNumber: index + 1, numberOfQuestions: questions.count)
            }
        }
    }
    
    func addQuestions() {
        addingQuestions = true
        let copy = Questions.exampleData.map { Questions(questions: $0.questions) }
        data.append(contentsOf: copy)
        addingQuestions = false
    }
}

struct FirstTypeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTypeView()
    }
}
