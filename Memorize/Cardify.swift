//
//  Cardify.swift
//  Memorize
//
//  Created by Александр Алгашев on 04.10.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotationInDegrees: Double
    var isFaceUp: Bool { self.rotationInDegrees < 90 }
    private var faceUpOpacity: Double { self.isFaceUp ? 1 : 0 }
    private var faceDownOpacity: Double { self.isFaceUp ? 0 : 1 }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private var cardRectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: self.cornerRadius)
    }
    
    var animatableData: Double {
        get { self.rotationInDegrees }
        set { self.rotationInDegrees = newValue }
    }
    
    init(isFaceUp: Bool) {
        self.rotationInDegrees = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                self.cardRectangle.fill(Color.white)
                self.cardRectangle.stroke(lineWidth: self.edgeLineWidth)
                content
            }.opacity(self.faceUpOpacity)
            Group {
                self.cardRectangle.fill()
            }.opacity(self.faceDownOpacity)
        }
        .rotation3DEffect(
            Angle.degrees(self.rotationInDegrees),
            axis: (0, 1, 0),
            perspective: 0.3
        )

    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

struct Cardify_Previews: PreviewProvider {
    static var previews: some View {
        Text("👻").cardify(isFaceUp: true).padding()
    }
}
