//
//  File.swift
//  swift-logic-operators
//
//  Created by Coen ten Thije Boonkkamp on 05/08/2024.
//

#if canImport(SwiftUI)
import Foundation
import SwiftUI

extension Bool? {
    public struct Picker<
        Content: SwiftUI.View,
        Label: SwiftUI.View
    >: SwiftUI.View {
        var content: (Bool?) -> Content
        var label: () -> Label
        @Binding var isOn: Bool?

        public init(
            _ content: @escaping (Bool?) -> Content,
            _ label: @escaping () -> Label,
            isOn: Binding<Bool?>
        ) {
            self.content = content
            self.label = label
            self._isOn = isOn
        }

        public init(
            _ label: String,
            isOn: Binding<Bool?>
        )
        where
        Content == SwiftUI.Text,
        Label == SwiftUI.Text {
            self = .init(
                {
                    switch $0 {
                    case .some(true):
                        SwiftUI.Text("true")
                    case .some(false):
                        SwiftUI.Text("false")
                    case .none:
                        SwiftUI.Text("nil")
                    }
                },
                { Text(label) },
                isOn: isOn
            )
        }

        public var body: some SwiftUI.View {

#if os(macOS)
            HStack(spacing: 5) {
                SwiftUI.Picker(
                    selection: $isOn.animation(),
                    content: {
                        ForEach(
                            Bool?.allCases,
                            id: \.self,
                            content: self.content
                        )
                    },
                    label: EmptyView.init
                )
                .pickerStyle(.segmented)
                .frame(width: 140)
                .fixedSize(horizontal: true, vertical: false)

                self.label()
//                    .fixedSize(horizontal: false, vertical: true)
//                    .lineLimit(nil)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                Spacer()
            }
#endif

#if os(iOS)
            VStack(alignment: .leading, spacing: 5) {
                self.label()

                HStack {
                    Spacer()
                    SwiftUI.Picker(
                        selection: $isOn.animation(),
                        content: {
                            ForEach(
                                Bool?.allCases,
                                id: \.self,
                                content: self.content
                            )
                        },
                        label: EmptyView.init
                    )
                    .pickerStyle(.segmented)
                    .frame(width: 140)
                    .fixedSize(horizontal: true, vertical: false)
                }
            }
#endif
        }
    }
}

// #Preview {
//    
//    @Previewable @State var isOn: Bool? = nil
//    @Previewable @State var isOn2: Bool? = nil
//    
//    NavigationStack {
//        Form {
//            Bool?.Picker("Very long question that just keeps on going as would be the case in any legal tech app.", isOn: $isOn)
//            
//            Bool?.Picker("Very short question", isOn: $isOn2)
//        }
//    }
// }
#endif
