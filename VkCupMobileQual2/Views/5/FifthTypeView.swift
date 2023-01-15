// FifthTypeView.swift

import SwiftUI

struct FifthTypeView: View {
    
    @State var data = Rating.exampleData
    @State var addingRatings = false
    
    var body: some View {
        OffsetScrollView(navigationTitle: "Ratings") {
            ForEach(Array(data.enumerated()), id: \.offset) { index, rating in
                ratingView(stars: rating.stars, index: index)
            }
        } onOffsetChange: { value in
            if addingRatings { return }
            
            let maxY = Int(value.maxY)
            if maxY < 1000 {
                addRatings()
            }
        }
    }
    
    @ViewBuilder func ratingView(stars: Int, index: Int) -> some View {
        HStack {
            ForEach(1..<6, id: \.self) { star in
                Group {
                    if star <= stars {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }
                .transition(.scale)
                .onTapGesture {
                    changeRating(for: index, star: star)
                }
            }
        }
        .foregroundColor(.orange)
        .font(.largeTitle)
        
    }
    
    func changeRating(for index: Int, star: Int) {
        withAnimation {
            data[index].stars = star
        }
    }
    
    func addRatings() {
        addingRatings = true
        data.append(contentsOf: Rating.exampleData)
        addingRatings = false
    }
}

struct FifthTypeView_Previews: PreviewProvider {
    static var previews: some View {
        FifthTypeView()
    }
}
