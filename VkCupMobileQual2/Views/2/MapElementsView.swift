// MapElementsView.swift

import SwiftUI

struct MapElement: Identifiable {
    var id = UUID()
    var variant: String
    var answer: String
    var rightAnswer: String
    var guessAnswer: String = ""
    var from: CGPoint = .zero
    var to: CGPoint = .zero
    var frame: CGRect = .zero
    var isCorrect: Bool {
        guessAnswer == rightAnswer
    }
}

struct MapElementsView: View {
    
    @State var mapElements: MapElements
    
    @State var elements = [MapElement]()
    
    @State var positions = [AnswerFrame]()
    @State var linePaths = [LinePath]()
    @State var connected = [String: String]()
    @State var connectedPairs = [ConnectedPair]()
    
    @State var correct: Bool?
    
    let offset: CGFloat = 17
    
    init(mapElements: MapElements) {
        self._mapElements = State(initialValue: mapElements)
        
        self._elements = State(initialValue: mapElements.variants.enumerated().map {
            MapElement(variant: $1, answer: mapElements.answers[$0], rightAnswer: mapElements.rightAnswers[$1]!)
        })
    }
    
    func dragGesture(variant: String) -> some Gesture {
        DragGesture(coordinateSpace: .named(mapElements.id))
            .onChanged { value in
                let location = CGPoint(x: value.location.x - offset, y: value.location.y - offset)
                
                if let index = linePaths.firstIndex(where: { $0.variant == variant }) {
                    linePaths[index].to = location
                } else {
                    let startLocation = CGPoint(x: value.startLocation.x - offset, y: value.startLocation.y - offset)
                    linePaths.append(LinePath(variant: variant, from: startLocation, to: location))
                }
            }
            .onEnded { value in
                
                for position in positions where position.frame.contains(value.location) {
                    if !connected.contains(where: { $0.value == position.name }) {
                        withAnimation {
                            connected[variant] = position.name
                            connectedPairs.append(
                                ConnectedPair(
                                    key: variant,
                                    value: position.name,
                                    isCorrect: connected[variant] == mapElements.rightAnswers[variant]
                                )
                            )
                            if let index = linePaths.firstIndex(where: { $0.variant == variant }) {
                                linePaths[index].isCorrect = connected[variant] == mapElements.rightAnswers[variant]
                            }
                        }
                        if connected.count == mapElements.answers.count {
                            checkIfCorrect()
                        }
                        return
                    }
                }
                withAnimation {
                    linePaths.removeAll(where: { $0.variant == variant })
                    guard let index = connected.index(forKey: variant) else { return }
                    connected.remove(at: index)
                    connectedPairs.removeAll(where: { $0.key == variant })
                }
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
                                .foregroundColor(connected[variant] != nil ? .white : .black)
                                .padding(5)
                                .if(correct == nil) {
                                    $0.gesture(dragGesture(variant: variant))
                                }
                                .if(correct != nil) {
                                    $0.background(connectedPairs.first(where: { $0.key == variant })!.isCorrect ? .green : .red)
                                } else: {
                                    $0.background(connected[variant] != nil ? .black : .white)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: 1)
                                }
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        ForEach(mapElements.answers, id: \.self) { variant in
                            Text(variant)
                                .foregroundColor(connected.contains(where: { $0.value == variant }) ? .white : .black)
                                .padding(5)
                                .if(correct != nil) {
                                    $0.background(connectedPairs.first(where: { $0.value == variant })!.isCorrect ? .green : .red)
                                } else: {
                                    $0.background(connected.contains(where: { $0.value == variant }) ? .black : .white)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: 1)
                                }
                                .readFrame(in: mapElements.id) { frame in
                                    positions.append(AnswerFrame(name: variant, frame: frame))
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
    
    func checkIfCorrect() {
        withAnimation {
            correct = connected == mapElements.rightAnswers
        }
    }
}

struct MapElementView_Previews: PreviewProvider {
    static var previews: some View {
        MapElementsView(mapElements: MapElements.exampleData.first!)
    }
}
