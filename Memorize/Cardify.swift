//
//  Cardify.swift
//  Memorize
//
//  Created by Александр Алгашев on 04.10.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private var cardRectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: self.cornerRadius)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if self.isFaceUp {
                self.cardRectangle.fill(Color.white)
                self.cardRectangle.stroke(lineWidth: self.edgeLineWidth)
                content
            } else {
                self.cardRectangle.fill()
            }
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
