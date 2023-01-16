// DragAndDrop.swift

import SwiftUI

struct DragAndDrop: Identifiable {
    var id = UUID()
    var text: String
    var gaps: [String]
    var variants: [String]
}

extension DragAndDrop {
    static let exampleData = [
        DragAndDrop(
            text: "Текст ___ несколькими пропусками ___ вариантами.",
            gaps: ["с", "и"],
            variants: [
                "один", "два", "с", "и"
            ]
        ),
        DragAndDrop(
            text: "Лучшая IDE для iOS разработки - ___ а для Android - ___",
            gaps: ["XCode", "Android Studio"],
            variants: [
                "VSCode", "Android Studio", "XCode", "AppCode"
            ]
        ),
        DragAndDrop(
            text: "Лучшая технология для iOS разработки - ___ а для Android - ___",
            gaps: ["SwiftUI", "Jetpack Compose"],
            variants: [
                "XML", "Jetpack Compose", "SwiftUI", "UIKit"
            ]
        ),
        DragAndDrop(
            text: "Лучшая компания в РФ только одна! И это - ___",
            gaps: ["ВК"],
            variants: [
                "Яндекс", "Сбербанк", "ВК"
            ]
        ),
        DragAndDrop(
            text: "Лучшая iOS для разработки - это ___",
            gaps: ["iOS 16"],
            variants: [
                "iOS 13", "iOS 14", "iOS 15", "iOS 16"
            ]
        ),
        DragAndDrop(
            text: "Самые милые - ___ но ___ тоже милые",
            gaps: ["Котики", "Собачки"],
            variants: [
                "Котики", "Собачки", "Хомячки", "Попугайчики"
            ]
        ),
        DragAndDrop(
            text: "Девушке можно подарить разные цветы, но лучше всего ___ хотя можно и ___",
            gaps: ["Ромашки", "не дарить"],
            variants: [
                "Розы", "Хризантемы", "Ромашки", "не дарить"
            ]
        ),
        DragAndDrop(
            text: "Естественно, в конкурсе от ВК выиграешь/ю ___",
            gaps: ["Я"],
            variants: [
                "Я", "Не я", "Ты"
            ]
        )
    ]
}
