//
//  Pie.swift
//  Memorize
//
//  Created by Александр Алгашев on 04.10.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let center = rect.center
        let radius = rect.minLength * 0.5
        let start = CGPoint(
            x: center.x + radius * cos(self.startAngle),
            y: center.y + radius * sin(self.startAngle)
        )
        
        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: self.startAngle,
            endAngle: self.endAngle,
            clockwise: !self.clockwise
        )
        path.addLine(to: center)
        
        return path
    }
}
