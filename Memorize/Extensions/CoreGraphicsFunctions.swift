//
//  CoreGraphicsFunctions.swift
//  Memorize
//
//  Created by Александр Алгашев on 04.10.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import SwiftUI

func cos(_ angle: Angle) -> CGFloat {
    cos(angle.radians.cgFloat)
}

func sin(_ angle: Angle) -> CGFloat {
    sin(angle.radians.cgFloat)
}
