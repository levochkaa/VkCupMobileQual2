// MapElements.swift

import Foundation

struct MapElements: Identifiable {
    var id = UUID()
    var variants: [String]
    var answers: [String]
    var rightAnswers: [String: String]
}

extension MapElements {
    static let exampleData = [
        MapElements(
            variants: ["один", "два", "три", "четыре"],
            answers: ["1", "2", "3", "4"],
            rightAnswers: ["один": "1", "два": "2", "три": "3", "четыре": "4"]
        ),
        MapElements(
            variants: ["iOS", "Android", "Windows", "macOS"],
            answers: ["эпле звонилка", "эпле компухтер", "гугле звонилка", "мелкомягкий компухтер"],
            rightAnswers: [
                "iOS": "эпле звонилка",
                "Android": "гугле звонилка",
                "Windows": "мелкомягкий компухтер",
                "macOS": "эпле компухтер"
            ]
        ),
        MapElements(
            variants: ["топ 1 снг", "топ 2 снг", "топ 3 снг"],
            answers: ["Яндекс", "Сбербанк", "ВК"],
            rightAnswers: ["топ 1 снг": "ВК", "топ 3 снг": "Сбербанк", "топ 2 снг": "Яндекс"]
        ),
        MapElements(
            variants: ["iOS", "Android", "Windows", "Linux"],
            answers: ["Jetpack Compose", "Windows Forms", "SwiftUI", "Error"],
            rightAnswers: ["iOS": "SwiftUI", "Android": "Jetpack Compose", "Windows": "Windows Forms", "Linux": "Error"]
        ),
        MapElements(
            variants: ["Google", "Apple", "VK", "Yandex"],
            answers: ["YNDX", "GOOGL", "AAPL", "VKCO"],
            rightAnswers: ["Google": "GOOGL", "Apple": "AAPL", "VK": "VKCO", "Yandex": "YNDX"]
        ),
        MapElements(
            variants: ["iOS/Android", "Backend", "Frontend", "Машинное обучение", "Спортивное программирование"],
            answers: ["Go", "ML", "JS", "Mobile", "Engine"],
            rightAnswers: [
                "iOS/Android": "Mobile",
                "Машинное обучение": "ML",
                "Спортивное программирование": "Engine",
                "Frontend": "JS",
                "Backend": "Go"
            ]
        ),
        MapElements(
            variants: ["1", "3", "2"],
            answers: ["Финал", "Отбор", "Квалификация"],
            rightAnswers: ["3": "Финал", "2": "Отбор", "1": "Квалификация"]
        ),
        MapElements(
            variants: ["VSCode", "Fleet", "XCode", "Android Studio"],
            answers: ["Microsoft", "Apple", "Google", "JetBrains"],
            rightAnswers: ["VSCode": "Microsoft", "Fleet": "JetBrains", "XCode": "Apple", "Android Studio": "Google"]
        ),
        MapElements(
            variants: ["Craiyon", "ChatGPT", "Midjourney"],
            answers: ["Smith & Nephew", "OpenAI", "Boris Dayma"],
            rightAnswers: ["Midjourney": "Smith & Nephew", "ChatGPT": "OpenAI", "Craiyon": "Boris Dayma"]
        )
    ]
}
