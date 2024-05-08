//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import Foundation

final class AppetizerListViewModel: ObservableObject {
    @Published var appetizers: [Appetizer] = []
    @Published var alertItem: AlertItem?
    
    func getAppetizers( ) {
        
        NetworkManager.shared.getAppetizers { [self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let appetizers):
                    // set appetizers to the data retrieved
                    self.appetizers = appetizers
                    
                case .failure(let error):
                    // error handling
                    switch error {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                    print(error.localizedDescription)
                }
            }

        }
    }
}
