// Question.swift

import Foundation

struct Questions: Identifiable {
    var id = UUID()
    var questions: [Question]
}

struct Question: Identifiable {
    var id = UUID()
    var name: String
    var variants: [QuestionVariant]
}

struct QuestionVariant: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var percentage: Int
    var isRight: Bool
}

extension Questions {
    static let exampleData = [
        Questions(questions: [
            Question(
                name: "Первый вопрос",
                variants: [
                    QuestionVariant(
                        name: "один",
                        percentage: 100,
                        isRight: true
                    ),
                    QuestionVariant(
                        name: "два",
                        percentage: 0,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "три",
                        percentage: 0,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "четыре",
                        percentage: 0,
                        isRight: false
                    )
                ]
            ),
            Question(
                name: "Второй вопрос",
                variants: [
                    QuestionVariant(
                        name: "один",
                        percentage: 67,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "два",
                        percentage: 23,
                        isRight: true
                    ),
                    QuestionVariant(
                        name: "три",
                        percentage: 5,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "четыре",
                        percentage: 5,
                        isRight: false
                    )
                ]
            ),
            Question(
                name: "Третий вопрос",
                variants: [
                    QuestionVariant(
                        name: "один",
                        percentage: 15,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "два",
                        percentage: 35,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "три",
                        percentage: 40,
                        isRight: true
                    ),
                    QuestionVariant(
                        name: "четыре",
                        percentage: 10,
                        isRight: false
                    )
                ]
            ),
            Question(
                name: "Четвертый вопрос",
                variants: [
                    QuestionVariant(
                        name: "один",
                        percentage: 25,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "два",
                        percentage: 16,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "три",
                        percentage: 40,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "четыре",
                        percentage: 19,
                        isRight: true
                    )
                ]
            )
        ]),
        Questions(questions: [
            Question(
                name: "Лучшая IDE для iOS разработки?",
                variants: [
                    QuestionVariant(
                        name: "XCode",
                        percentage: 0,
                        isRight: true
                    ),
                    QuestionVariant(
                        name: "AppCode",
                        percentage: 80,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "VSCode",
                        percentage: 20,
                        isRight: false
                    )
                ]
            ),
            Question(
                name: "Лучшая технология для iOS разработки?",
                variants: [
                    QuestionVariant(
                        name: "UIKit",
                        percentage: 50,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "SwiftUI",
                        percentage: 50,
                        isRight: true
                    )
                ]
            ),
            Question(
                name: "Лучшая компания в РФ?",
                variants: [
                    QuestionVariant(
                        name: "Яндекс",
                        percentage: 20,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "Сбербанк",
                        percentage: 20,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "ВК",
                        percentage: 60,
                        isRight: true
                    )
                ]
            ),
            Question(
                name: "Лучшая iOS для разработки?",
                variants: [
                    QuestionVariant(
                        name: "iOS 13",
                        percentage: 40,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "iOS 14",
                        percentage: 20,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "iOS 15",
                        percentage: 30,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "iOS 16",
                        percentage: 10,
                        isRight: true
                    )
                ]
            )
        ]),
        Questions(questions: [
            Question(
                name: "Кто милее?",
                variants: [
                    QuestionVariant(
                        name: "Котики",
                        percentage: 50,
                        isRight: true
                    ),
                    QuestionVariant(
                        name: "Собачки",
                        percentage: 50,
                        isRight: false
                    )
                ]
            ),
            Question(
                name: "Какие цветы дарить девушке?",
                variants: [
                    QuestionVariant(
                        name: "Хризантемы",
                        percentage: 20,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "Розы",
                        percentage: 20,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "Ромашки",
                        percentage: 10,
                        isRight: true
                    ),
                    QuestionVariant(
                        name: "Не дарить",
                        percentage: 50,
                        isRight: false
                    )
                ]
            ),
            Question(
                name: "Лучшая мобильная ОС?",
                variants: [
                    QuestionVariant(
                        name: "Android",
                        percentage: 50,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "iOS",
                        percentage: 50,
                        isRight: true
                    )
                ]
            ),
            Question(
                name: "Кто выиграет в конкурсе от ВК?",
                variants: [
                    QuestionVariant(
                        name: "Я",
                        percentage: 100,
                        isRight: true
                    ),
                    QuestionVariant(
                        name: "Не я",
                        percentage: 0,
                        isRight: false
                    ),
                    QuestionVariant(
                        name: "Ты",
                        percentage: 0,
                        isRight: false
                    )
                ]
            )
        ])
    ]
}
