// GeometryProxyPreferenceKey.swift

import SwiftUI

struct GeometryProxyPreferenceKey: PreferenceKey {
    static var defaultValue = CustomGeometryProxy(frame: .zero, size: .zero)
    static func reduce(value: inout CustomGeometryProxy, nextValue: () -> CustomGeometryProxy) {}
}
