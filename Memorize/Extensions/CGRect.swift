//
//  CGRect.swift
//  Memorize
//
//  Created by Александр Алгашев on 04.10.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import CoreGraphics

extension CGRect {
    var center: CGPoint { CGPoint(x: self.midX, y: self.midY) }
    var minLength: CGFloat { min(self.width, self.height) }
}
