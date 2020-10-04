//
//  Array.swift
//  Memorize
//
//  Created by Александр Алгашев on 27.09.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? { self.count == 1 ? self.first : nil }
}

extension Array where Element: Identifiable {
    func firstIndex(matching element: Element) -> Int? {
        self.firstIndex { $0.id == element.id }
    }
}
