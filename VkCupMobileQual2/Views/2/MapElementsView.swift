// MapElementsView.swift

import SwiftUI

struct MapElementsView: View {
    
    @State var mapElements: MapElements
    
    @State var positions = [AnswerFrame]()
    @State var linePaths = [LinePath]()
    @State var connectedPairs = [ConnectedPair]()
    
    @State var correct: Bool?
    
    let offset: CGFloat = 17
    
    func dragGesture(variant: String) -> some Gesture {
        DragGesture(coordinateSpace: .named(mapElements.id))
            .onChanged { value in
                onDragChanged(value, variant: variant)
            }
            .onEnded { value in
                onDragEnded(value, variant: variant)
            }
    }
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(linePaths) { linePath in
                    Path { path in
                        path.move(to: linePath.from)
                        path.addLine(to: linePath.to)
                    }
                    .stroke(correct == nil ? .black : linePath.isCorrect ? .green : .red, lineWidth: 1)
                }
                
                HStack {
                    Spacer()
                    
                    VStack {
                        ForEach(mapElements.variants, id: \.self) { variant in
                            Text(variant)
                                .foregroundColor(
                                    connectedPairs.contains(where: { $0.variant == variant }) ? .white : .black
                                )
                                .padding(5)
                                .if(correct == nil) {
                                    $0
                                        .gesture(dragGesture(variant: variant))
                                        .background(
                                            connectedPairs.contains(where: { $0.variant == variant }) ? .black : .white
                                        )
                                } else: {
                                    $0.background(
                                        connectedPairs.first(where: { $0.variant == variant })!.isCorrect
                                        ? .green
                                        : .red
                                    )
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .contentShape(RoundedRectangle(cornerRadius: 15))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: 1)
                                }
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        ForEach(mapElements.answers, id: \.self) { answer in
                            Text(answer)
                                .foregroundColor(
                                    connectedPairs.contains(where: { $0.answer == answer }) ? .white : .black
                                )
                                .padding(5)
                                .if(correct != nil) {
                                    $0.background(
                                        connectedPairs.first(where: { $0.answer == answer })!.isCorrect ? .green : .red
                                    )
                                } else: {
                                    $0.background(
                                        connectedPairs.contains(where: { $0.answer == answer }) ? .black : .white
                                    )
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .contentShape(RoundedRectangle(cornerRadius: 15))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: 1)
                                }
                                .readFrame(in: mapElements.id) { frame in
                                    positions.append(AnswerFrame(name: answer, frame: frame))
                                }
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .coordinateSpace(name: mapElements.id)
            
            CorrectView(correct: $correct)
        }
        
        Divider()
    }
    
    func onDragChanged(_ value: DragGesture.Value, variant: String) {
        let location = CGPoint(x: value.location.x - offset, y: value.location.y - offset)
        
        if let index = linePaths.firstIndex(where: { $0.variant == variant }) {
            linePaths[index].to = location
        } else {
            let startLocation = CGPoint(x: value.startLocation.x - offset, y: value.startLocation.y - offset)
            linePaths.append(LinePath(variant: variant, from: startLocation, to: location))
        }
    }
    
    func onDragEnded(_ value: DragGesture.Value, variant: String) {
        for position in positions where position.frame.contains(value.location) {
            if connectedPairs.contains(where: { $0.answer == position.name }) { continue }
            
            withAnimation {
                if let index = connectedPairs.firstIndex(where: { $0.variant == variant }) {
                    connectedPairs[index] = ConnectedPair(
                        variant: variant,
                        answer: position.name,
                        isCorrect: position.name == mapElements.rightAnswers[variant]
                    )
                } else {
                    connectedPairs.append(
                        ConnectedPair(
                            variant: variant,
                            answer: position.name,
                            isCorrect: position.name == mapElements.rightAnswers[variant]
                        )
                    )
                }
            }
            
            if let index = linePaths.firstIndex(where: { $0.variant == variant }) {
                linePaths[index].isCorrect = position.name == mapElements.rightAnswers[variant]
            }
            
            if connectedPairs.count == mapElements.answers.count {
                checkIfCorrect()
            }
            return
        }
        
        withAnimation {
            linePaths.removeAll(where: { $0.variant == variant })
            connectedPairs.removeAll(where: { $0.variant == variant })
        }
    }
    
    func checkIfCorrect() {
        let connectedPairsDictionary = connectedPairs.reduce([String: String]()) { result, next in
            var dictionary = result
            dictionary[next.variant] = next.answer
            return dictionary
        }
        withAnimation {
            correct = connectedPairsDictionary == mapElements.rightAnswers
        }
    }
}

struct MapElementView_Previews: PreviewProvider {
    static var previews: some View {
        MapElementsView(mapElements: MapElements.exampleData.first!)
    }
}
