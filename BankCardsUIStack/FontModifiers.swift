//
//  FontModifiers.swift
//  BankCardsUIStack
//
//  Created by Ion on 26.04.2021.
//

import SwiftUI

struct PageTitleFontModifier: ViewModifier {
    var size: CGFloat = 40
    var lineSpacing: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Ambit-Black", size: size))
            .lineSpacing(lineSpacing)
    }
}



struct CardNumberFontModifier: ViewModifier {
    var size: CGFloat = 40
    var color: String = "white"
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Ambit-Regular", size: size))
            .foregroundColor(.white)
    }
}



struct CardInfoFontModifier: ViewModifier {
    var size: CGFloat = 12
    var color: String = "white"
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Ambit-Regular", size: size))
            .foregroundColor(.white).opacity(0.9)
            .lineSpacing(24)
    }
}


struct MoneyBalanceFontModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Ambit-Bold", size: 32))
            .foregroundColor(.white)
            .lineSpacing(24)

    }
}
