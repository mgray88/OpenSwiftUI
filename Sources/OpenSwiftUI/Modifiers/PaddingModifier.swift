import Foundation

extension View {
    public func padding(_ insets: EdgeInsets) -> some View {
        return ModifiedContent(content: self, modifier: PaddingModifier(insets))
    }
    
    public func padding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
        return ModifiedContent(content: self, modifier: PaddingModifier(edges, length))
    }
    
    public func padding(_ length: CGFloat) -> some View {
        return ModifiedContent(content: self, modifier: PaddingModifier(length))
    }
}

struct PaddingModifier: ViewModifier {
    static let defaultPadding: CGFloat = 8
    
    typealias Body = Never
    typealias Content = View
    
    var value: EdgeInsets
    
    init(_ insets: EdgeInsets) {
        self.value = insets
    }
    
    init(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) {
        let computedLength = length ?? Self.defaultPadding
        self.value = EdgeInsets(top: edges.contains(.top) ? computedLength : 0,
                                leading: edges.contains(.leading) ? computedLength : 0,
                                bottom: edges.contains(.bottom) ? computedLength : 0,
                                trailing: edges.contains(.trailing) ? computedLength : 0)
    }
    
    init(_ length: CGFloat) {
        self.value = EdgeInsets(top: length, leading: length, bottom: length, trailing: length)
    }
}

extension PaddingModifier: CustomStringConvertible {
    public var description: String {
        return "PaddingModifier {padding: \(value)}"
    }
}
