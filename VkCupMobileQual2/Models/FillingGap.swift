// FillingGap.swift

import Foundation

struct FillingGap: Identifiable {
    var id = UUID()
    var text: String
    var gaps: [String]
}

extension FillingGap {
    static let exampleData = [
        FillingGap(
            text: "Текст ___ несколькими пропусками ___ вариантами.",
            gaps: ["с", "и"]
        ),
        FillingGap(
            text: "Лучшая IDE для iOS разработки - ___ а для Android - ___",
            gaps: ["XCode", "Android Studio"]
        ),
        FillingGap(
            text: "Лучшая технология для iOS разработки - ___ а для Android - ___",
            gaps: ["SwiftUI", "Jetpack Compose"]
        ),
        FillingGap(
            text: "Лучшая компания в РФ только одна! И это - ___",
            gaps: ["ВК"]
        ),
        FillingGap(
            text: "Лучшая iOS для разработки - это ___",
            gaps: ["iOS 16"]
        ),
        FillingGap(
            text: "Самые милые - ___ но ___ тоже милые",
            gaps: ["Котики", "Собачки"]
        ),
        FillingGap(
            text: "Девушке можно подарить разные цветы, но лучше всего ___ хотя можно и ___",
            gaps: ["Ромашки", "не дарить"]
        ),
        FillingGap(
            text: "Естественно, в конкурсе от ВК выиграет/ю ___",
            gaps: ["Я"]
        )
    ]
}
