// OffsetScrollView.swift

import SwiftUI

struct OffsetScrollView<Content: View>: View {
    
    let navigationTitle: String
    let horizontalAlignment: HorizontalAlignment
    let content: () -> Content
    let onOffsetChange: (CGRect) -> Void
    
    let scrollSpace = "scrollSpace"
    
    init(
        navigationTitle: String,
        horizontalAlignment: HorizontalAlignment = .center,
        content: @escaping () -> Content,
        onOffsetChange: @escaping (CGRect) -> Void
    ) {
        self.navigationTitle = navigationTitle
        self.horizontalAlignment = horizontalAlignment
        self.content = content
        self.onOffsetChange = onOffsetChange
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    LazyVStack(alignment: horizontalAlignment, spacing: 10) {
                        content()
                    }
                    .padding(.horizontal)
                    
                    GeometryReader { geometryProxy in
                        Color.clear.preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometryProxy.frame(in: .named(scrollSpace))
                        )
                    }
                }
            }
            .navigationTitle(navigationTitle)
            .coordinateSpace(name: scrollSpace)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                onOffsetChange(value)
            }
        }
    }
}
