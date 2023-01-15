// ThirdTypeView.swift

import SwiftUI

struct ThirdTypeView: View {
    
    @State var data = DragAndDrop.exampleData
    @State var addingDragAndDrops = false
    
    var body: some View {
        OffsetScrollView(navigationTitle: "Drag & Drop") {
            ForEach(data) { dragAndDrop in
                DragAndDropView(dragAndDrop: dragAndDrop)
            }
        } onOffsetChange: { value in
            if addingDragAndDrops { return }
            
            let maxY = Int(value.maxY)
            if maxY < 1000 {
                addDragAndDrops()
            }
        }
    }
    
    func addDragAndDrops() {
        addingDragAndDrops = true
        let copy = DragAndDrop.exampleData.map { DragAndDrop(text: $0.text, gaps: $0.gaps, variants: $0.variants) }
        data.append(contentsOf: copy)
        addingDragAndDrops = false
    }
}

struct ThirdTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdTypeView()
    }
}
