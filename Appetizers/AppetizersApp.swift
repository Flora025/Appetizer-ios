//
//  AppetizersApp.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import SwiftUI

@main
struct AppetizersApp: App {
    
    var order = Order()
    
    var body: some Scene {
        WindowGroup {
            AppetizerTabView().environmentObject(order) // all in the tab view will have access to order
        }
    }
}
