//
//  Order.swift
//  Appetizers
//
//  Created by zhanghan on 5/8/24.
//

import SwiftUI

final class Order: ObservableObject {
    
    @Published var items: [Appetizer] = []
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    func add(_ appetizer: Appetizer) {
        items.append(appetizer)
        // also add in db for backup
        NetworkManager.shared.addOrderItem(appetizer)
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        
        // also delete in db for backup
        let itemsToDelete = Array(offsets)
        for index in itemsToDelete {
            let appetizerToDelete = items[index]
            NetworkManager.shared.deleteOrderItem(itemID: appetizerToDelete.id)
        }
    }
}
