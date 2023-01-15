// SecondTypeView.swift

import SwiftUI

struct SecondTypeView: View {
    
    @State var data = MapElements.exampleData
    @State var addingMapElements = false
    
    var body: some View {
        OffsetScrollView(navigationTitle: "Map Elements") {
            ForEach(data) { mapElements in
                MapElementsView(mapElements: mapElements)
            }
        } onOffsetChange: { value in
            if addingMapElements { return }
            
            let maxY = Int(value.maxY)
            if maxY < 1000 {
                addMapElements()
            }
        }
    }
    
    func addMapElements() {
        addingMapElements = true
        let copy = MapElements.exampleData.map { MapElements(variants: $0.variants, answers: $0.answers, rightAnswers: $0.rightAnswers) }
        data.append(contentsOf: copy)
        addingMapElements = false
    }
}

struct SecondTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTypeView()
    }
}
