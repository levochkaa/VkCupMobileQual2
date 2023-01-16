// View+readFrame.swift

import SwiftUI

extension View {
    func readFrame(
        in coordinateSpaceName: AnyHashable,
        _ value: @escaping (_ frame: CGRect) -> Void
    ) -> some View {
        background {
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(
                        key: FramePreferenceKey.self,
                        value: geometryProxy.frame(in: .named(coordinateSpaceName))
                    )
            }
        }
        .onPreferenceChange(FramePreferenceKey.self) { frame in
            value(frame)
        }
    }
}
