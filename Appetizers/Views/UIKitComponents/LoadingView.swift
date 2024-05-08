//
//  LoadingView.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import SwiftUI

// helper func
struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.brandPrimary
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    func  updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
}


struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            ActivityIndicator() // create the loading sign
        }
    }
}
