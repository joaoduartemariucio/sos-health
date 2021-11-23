//
//  RoundedRectangleButton.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 13/11/21.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {

    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(currentForegroundColor, lineWidth: 1)
            )
            .padding([.top, .bottom], 10)
            .font(Font.system(size: 19, weight: .semibold))
    }
}

struct RoundedRectangleButton: View {

    private static let buttonHorizontalMargins: CGFloat = 20

    var backgroundColor: Color
    var foregroundColor: Color

    private let title: LocalizedStringKey
    private let action: () -> Void
    private let disabled: Bool

    init(title: LocalizedStringKey,
         disabled: Bool = false,
         backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.action = action
        self.disabled = disabled
    }

    var body: some View {
        Button(action: self.action) {
            Text(self.title, bundle: .main)
                .frame(maxWidth: .infinity)
                .font(.body)
        }
        .buttonStyle(
            RoundedRectangleButtonStyle(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                isDisabled: disabled
            )
        )
        .disabled(self.disabled)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
