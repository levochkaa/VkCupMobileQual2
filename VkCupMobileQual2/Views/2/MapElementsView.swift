// MapElementsView.swift

import SwiftUI

// TODO: rewrite

struct MapElement: Identifiable {
    var id = UUID()
    var variant: String
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
    
    @State var positions = [AnswerPosition]()
    @State var linePaths = [LinePath]()
    @State var connected = [String: String]()
    @State var connectedPairs = [ConnectedPair]()
    
    @State var boxSize: CGSize = .zero
    @State var correct: Bool?
    
    let offset: CGFloat = 17
    
    init(mapElements: MapElements) {
        self._mapElements = State(initialValue: mapElements)
        
        self._elements.wrappedValue = mapElements.variants.enumerated().map {
            MapElement(variant: $1, rightAnswer: mapElements.answers[$0])
        }
    }
    
    func dragGesture(id: String) -> some Gesture {
        DragGesture(coordinateSpace: .named(mapElements.id))
            .onChanged { value in
                let location = CGPoint(x: value.location.x - offset, y: value.location.y - offset)
                if let index = linePaths.firstIndex(where: { $0.id == id }) {
                    linePaths[index].to = location
                } else {
                    let startLocation = CGPoint(x: value.startLocation.x - offset, y: value.startLocation.y - offset)
                    linePaths.append(LinePath(id: id, from: startLocation, to: location))
                }
            }
            .onEnded { value in
                for position in positions where position.proxy.frame.contains(value.location) {
                    if !connected.contains(where: { $0.value == position.name }) {
                        withAnimation {
                            connected[id] = position.name
                            connectedPairs.append(
                                ConnectedPair(
                                    key: id,
                                    value: position.name,
                                    isCorrect: connected[id] == mapElements.rightAnswers[id]
                                )
                            )
                            if let index = linePaths.firstIndex(where: { $0.id == id }) {
                                linePaths[index].isCorrect = connected[id] == mapElements.rightAnswers[id]
                            }
                        }
                        if connected.count == mapElements.answers.count {
                            checkIfCorrect()
                        }
                        return
                    }
                }
                withAnimation {
                    linePaths.removeAll(where: { $0.id == id })
                    guard let index = connected.index(forKey: id) else { return }
                    connected.remove(at: index)
                    connectedPairs.removeAll(where: { $0.key == id })
                }
            }
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        ForEach(mapElements.variants, id: \.self) { variant in
                            Text(variant)
                                .foregroundColor(connected[variant] != nil ? .white : .black)
                                .padding(5)
                                .if(correct == nil) {
                                    $0.gesture(dragGesture(id: variant))
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
                                .readProxy(in: mapElements.id) { geometryProxy in
                                    let newPosition = AnswerPosition(proxy: geometryProxy, name: variant)
                                    positions.append(newPosition)
                                }
                        }
                    }
                    
                    Spacer()
                }
                .readSize { boxSize = $0 }
                
                ForEach(linePaths) { linePath in
                    Path { path in
                        path.move(to: linePath.from)
                        path.addLine(to: linePath.to)
                    }
                    .stroke(correct == nil ? .black : linePath.isCorrect ? .green : .red, lineWidth: 1)
                }
            }
            .if(boxSize != .zero) {
                $0.frame(width: boxSize.width, height: boxSize.height)
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
