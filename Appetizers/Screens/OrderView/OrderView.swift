//
//  OrderView.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import SwiftUI

struct OrderView: View {
    
    @State private var orderItems = MockData.orderItems
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // list of order items
                    List {
                        ForEach(orderItems) { appetizer in
                            AppetizerListCell(appetizer: appetizer)
                        }
                        // swipe to delete
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                    
                    Button {
                        print("order placed")
                    } label: {
                        APButton(title: "$99.99 - Place Order")
                    }
                    .padding(.bottom, 25)
                }
                
                // empty
                if orderItems.isEmpty {
                    EmptyState(imageName: "empty-order",
                               message: "You have no items in your order. Please add an appetizer!")
                }
            }
            .navigationTitle("📄 Order")
                
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        orderItems.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
