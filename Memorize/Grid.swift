//
//  Grid.swift
//  Memorize
//
//  Created by Александр Алгашев on 27.09.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import SwiftUI

struct Grid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var itemView: (Item) -> ItemView
    
    init(_ items: [Item], itemView: @escaping (Item) -> ItemView) {
        self.items = items
        self.itemView = itemView
    }
    
    var body: some View {
        GeometryReader { geometry in
            let layout = GridLayout(itemCount: self.items.count, in: geometry.size)
            self.body(for: layout)
        }
    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(self.items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        Group {
            if let index = self.items.firstIndex(matching: item) {
                self.itemView(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
            }
        }
    }
}
