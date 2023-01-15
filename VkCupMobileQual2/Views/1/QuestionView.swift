// QuestionView.swift

import SwiftUI

struct QuestionView: View {
    
    @State var question: Question
    @State var questionNumber: Int
    @State var numberOfQuestions: Int
    
    @State var tapped = false
    @State var tappedVariant: QuestionVariant?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Вопрос \(questionNumber)/\(numberOfQuestions)")
                .foregroundColor(.gray)
            
            Text(question.name)
                .font(.system(.title, design: .rounded, weight: .bold))
            
            ForEach(question.variants) { variant in
                variantView(for: variant)
            }
        }
        .animation(.default, value: tapped)
        .animation(.default, value: tappedVariant)
    }
    
    @ViewBuilder func variantView(for variant: QuestionVariant) -> some View {
        HStack {
            Text(variant.name)
            
            Spacer()
            
            
            Group {
                if tapped {
                    Group {
                        if variant.isRight {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        } else if !variant.isRight, variant == tappedVariant {
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                        }
                    }
                    .transition(.scale)
                    
                    Text("\(variant.percentage)%")
                        .transition(.move(edge: .trailing))
                }
            }
        }
        .padding(10)
        .background {
            let maxWidth = (UIScreen.main.bounds.width - 32) * (CGFloat(variant.percentage) / 100)
            ZStack(alignment: .leading) {
                Color.lightGray
                
                Group {
                    if tappedVariant == variant {
                        variant.isRight ? Color.lightGreen : Color.red
                    } else if tapped {
                        variant.isRight ? Color.lightGreen : Color.gray3
                    }
                }
                .frame(maxWidth: maxWidth)
                .transition(.move(edge: .leading))
            }
        }
        .cornerRadius(20)
        .onTapGesture {
            tapped = true
            if tappedVariant == nil {
                tappedVariant = variant
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let index = 0
        let questions = Questions.exampleData[index]
        QuestionView(
            question: questions.questions[1],
            questionNumber: index + 1,
            numberOfQuestions: questions.questions.count
        )
        .padding(.horizontal)
    }
}
