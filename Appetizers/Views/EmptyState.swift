//
//  EmptyState.swift
//  Appetizers
//
//  Created by zhanghan on 5/8/24.
//

import SwiftUI

struct EmptyState: View {
    
    let imageName: String
    let message: String
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .offset(y: -50)
        
    }
}

struct EmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmptyState(message: "empty-order", imageName: "This is a sample message long enough for testing.")
    }
}
