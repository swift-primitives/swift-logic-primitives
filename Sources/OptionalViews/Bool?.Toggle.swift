//
//  File.swift
//  swift-logic-operators
//
//  Created by Coen ten Thije Boonkkamp on 05/08/2024.
//

#if canImport(SwiftUI)
import OptionalLogic
import SwiftUI

extension Bool?: /*@retroactive*/ CaseIterable {
    public static let allCases: [Self] = [true, false, nil]
}

extension Bool? {
    internal var nonOptional: Bool {
        get {
            self ?? false
        }
        set {
            self = .some(newValue)
        }
    }
}

extension Bool? {
    public struct Toggle<
        Label: SwiftUI.View,
        NilLabel: SwiftUI.View
    >: SwiftUI.View {
        var label: () -> Label
        var nilLabel: () -> NilLabel
        @Binding var isOn: Bool?

        public init(
            _ label: @escaping () -> Label,
            _ nilLabel: @escaping () -> NilLabel,
            isOn: Binding<Bool?>
        ) {
            self.label = label
            self.nilLabel = nilLabel
            self._isOn = isOn
        }

        public init(
            _ label: String,
            isOn: Binding<Bool?>
        )
        where
        Label == SwiftUI.Text,
        NilLabel == SwiftUI.Text {
            self.label = { Text(label) }
            self.nilLabel = { Text("nil") }
            self._isOn = isOn
        }

        public var body: some SwiftUI.View {

            if let _ = isOn {
                HStack {
                    SwiftUI.Toggle(
                        isOn: $isOn.nonOptional.animation(),
                        label: label
                    )
                    Button {
                        isOn = nil
                    } label: {
                        Text("nil")
                    }.buttonStyle(.borderless)

                }
            } else {
                SwiftUI.Toggle(
                    isOn: $isOn.nonOptional.animation(),
                    label: label
                )
            }
        }
    }
}

// #Preview("Test") {
//    
//    @Previewable @State var isOn: Bool? = nil
//    
//    NavigationStack {
//        Form {
//            Bool?.Toggle("Label", isOn: $isOn)
//            
//            HStack(spacing: 5) {
//                RoundedRectangle(cornerRadius: 5)
//                .fill( Color.isOn(isOn) )
//                    .frame(width: 15, height: 15)
//                    
//                    .onTapGesture {
//                        isOn = switch isOn {
//                        case .some(true):
//                            false
//                        case .some(false):
//                            nil
//                        case .none:
//                            true
//                        }
//                    }
//                Text("Label")
//                    .onTapGesture {
//                        isOn = switch isOn {
//                        case .some(true):
//                            false
//                        case .some(false):
//                            nil
//                        case .none:
//                            true
//                        }
//                    }
//                Spacer()
//                
//            }
//            .frame(height: 30)
//            
//        }
//        .frame(width: 200, height: 200)
//    }
// }
//

#if os(macOS)
extension NSColor {
    static func isOn(_ isOn: Bool?) -> NSColor {
        switch isOn {
        case .some(true): return .green
        case .some(false): return .red
        case .none: return .controlColor
        }
    }
}

//
// extension Color {
//    static func isOn(_ isOn: Bool?) -> Color {
//        Color(nsColor: .isOn(isOn))
//    }
// }
#endif

#if os(iOS)
extension Color {
    static func isOn(_ isOn: Bool?) -> Color {
        Color.green
    }
}
#endif

#endif
