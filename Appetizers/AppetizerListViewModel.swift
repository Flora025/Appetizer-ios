//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import Foundation

final class AppetizerListViewModel: ObservableObject {
    @Published var appetizers: [Appetizer] = []
    
    func getAppetizers( ) {
        
        NetworkManager.shared.getAppetizers { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let appetizers):
                    // set appetizers to the data retrieved
                    self.appetizers = appetizers
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

        }
    }
}
