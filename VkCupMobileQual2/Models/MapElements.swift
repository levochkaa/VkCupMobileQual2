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
            rightAnswers: ["iOS": "эпле звонилка", "Android": "гугле звонилка", "Windows": "мелкомягкий компухтер", "macOS": "эпле компухтер"]
        ),
        MapElements(
            variants: ["топ 1 снг", "топ 2 снг", "топ 3 снг"],
            answers: ["Яндекс", "Сбербанк", "ВК"],
            rightAnswers: ["топ 1 снг": "ВК", "топ 3 снг": "Сбербанк", "топ 2 снг": "Яндекс"]
        ),
        MapElements(
            variants: ["один", "два", "три", "четыре"],
            answers: ["1", "2", "3", "4"],
            rightAnswers: ["один": "1", "два": "2", "три": "3", "четыре": "4"]
        ),
        MapElements(
            variants: ["один", "два", "три", "четыре"],
            answers: ["1", "2", "3", "4"],
            rightAnswers: ["один": "1", "два": "2", "три": "3", "четыре": "4"]
        ),
        MapElements(
            variants: ["один", "два", "три", "четыре"],
            answers: ["1", "2", "3", "4"],
            rightAnswers: ["один": "1", "два": "2", "три": "3", "четыре": "4"]
        ),
        MapElements(
            variants: ["один", "два", "три", "четыре"],
            answers: ["1", "2", "3", "4"],
            rightAnswers: ["один": "1", "два": "2", "три": "3", "четыре": "4"]
        ),
        MapElements(
            variants: ["один", "два", "три", "четыре"],
            answers: ["1", "2", "3", "4"],
            rightAnswers: ["один": "1", "два": "2", "три": "3", "четыре": "4"]
        ),
        MapElements(
            variants: ["один", "два", "три", "четыре"],
            answers: ["1", "2", "3", "4"],
            rightAnswers: ["один": "1", "два": "2", "три": "3", "четыре": "4"]
        ),
        MapElements(
            variants: ["один", "два", "три", "четыре"],
            answers: ["1", "2", "3", "4"],
            rightAnswers: ["один": "1", "два": "2", "три": "3", "четыре": "4"]
        ),
        MapElements(
            variants: ["один", "два", "три", "четыре"],
            answers: ["1", "2", "3", "4"],
            rightAnswers: ["один": "1", "два": "2", "три": "3", "четыре": "4"]
        )
    ]
}
