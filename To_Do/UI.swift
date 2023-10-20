//
//  UI.swift
//  To_Do
//
//  Created by Anna Ershova on 12.10.2023.
//

import Foundation
import SwiftUI

let color1 = Color(hex: 0xF2F1F0)
let color2 = Color(hex: 0xC0C9CC)
let color3 = Color(hex: 0xA39D92)
let color4 = Color(hex: 0x636059)
let font1 = ("Copperplate", 60.00)
let font2 = ("PartyLetPlain", 20.00)
let font3 = ("Copperplate-Light", 60.00)

extension Color {
    public static var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: Color.colors),
                       startPoint: .bottom,
                       endPoint: .top)
    }
    
    public static var text: Self {
        Color(hex: 0x000000)
    }
    
    public static var colors: [Color] {
        [color1, color2, color3]
    }
    
    public init(hex: UInt32) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8)  & 0xFF) / 255.0
        let blue = CGFloat((hex) & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

public struct ListStyle: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .font(.custom(font3.0, size: font3.1 * 0.5))
            .foregroundColor(color4)
    }
}

public struct ButtonStyles: ButtonStyle {
    @Binding var tapped: Bool
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .background(!tapped ? Image(systemName: "circle") : Image(systemName: "circle.fill"))
            .foregroundColor(!tapped ? .gray : .green)
            .padding()
    }
}

struct ClearButton: ViewModifier {
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: { self.text = "" }) {
                    Image(systemName: "delete.left")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
    }
}

public struct TaskTextStyle: ViewModifier {
    @Binding var tapped: Bool

    public func body(content: Content) -> some View {
        content
            .foregroundColor(!tapped ? color4 : .text)
            .strikethrough(tapped)
            .onTapGesture(perform: {
                tapped.toggle()
            })
    }
}
