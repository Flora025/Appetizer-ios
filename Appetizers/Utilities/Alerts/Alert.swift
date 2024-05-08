//
//  Alert.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                      message: Text("URL is invalid. Please contact support"),
                                      dismissButton: .default(Text("OK")))
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                      message: Text("Please try again later or contact support."),
                                      dismissButton: .default(Text("OK")))
    static let invalidData = AlertItem(title: Text("Invalid Data"),
                                      message: Text("Data is invalid."),
                                      dismissButton: .default(Text("OK")))
    static let unableToComplete = AlertItem(title: Text("Unable to Complete"),
                                      message: Text("Unable to Complete."),
                                      dismissButton: .default(Text("OK")))
    static let invalidForm = AlertItem(title: Text("Invalid Form"),
                                      message: Text("Please ensure all fields in the form have been filled out."),
                                      dismissButton: .default(Text("OK")))
    static let invalidEmail = AlertItem(title: Text("Invalid Email"),
                                      message: Text("Please ensure your email is correct."),
                                      dismissButton: .default(Text("OK")))
}
