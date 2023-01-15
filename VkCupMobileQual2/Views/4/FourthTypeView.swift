// FourthTypeView.swift

import SwiftUI

struct FourthTypeView: View {
    
    @State var data = FillingGap.exampleData
    @State var addingFillingGaps = false
    
    var body: some View {
        OffsetScrollView(navigationTitle: "Filling Gaps") {
            ForEach(data) { fillingGap in
                FillingGapView(fillingGap: fillingGap)
            }
        } onOffsetChange: { value in
            if addingFillingGaps { return }
            
            let maxY = Int(value.maxY)
            if maxY < 1000 {
                addFillingGaps()
            }
        }
    }
    
    func addFillingGaps() {
        addingFillingGaps = true
        let copy = FillingGap.exampleData.map { FillingGap(text: $0.text, gaps: $0.gaps) }
        data.append(contentsOf: copy)
        addingFillingGaps = false
    }
}

struct FourthTypeView_Previews: PreviewProvider {
    static var previews: some View {
        FourthTypeView()
    }
}
