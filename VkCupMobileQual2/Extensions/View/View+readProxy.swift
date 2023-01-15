// View+readProxy.swift

import SwiftUI

extension View {
    func readProxy(
        in coordinateSpaceName: AnyHashable,
        _ value: @escaping (_ geometryProxy: CustomGeometryProxy) -> Void
    ) -> some View {
        background {
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(
                        key: GeometryProxyPreferenceKey.self,
                        value: CustomGeometryProxy(
                            frame: geometryProxy.frame(in: .named(coordinateSpaceName)),
                            size: geometryProxy.size
                        )
                    )
            }
        }
        .onPreferenceChange(GeometryProxyPreferenceKey.self) { geometryProxy in
            value(geometryProxy)
        }
    }
}
