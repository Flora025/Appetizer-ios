//
//  RemoteImage.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    
    func load(fromURLString urlString: String) {
        NetworkManager.shared.downloadImage(fromURLString: urlString) { uiImage in
            // if image does not exist, return
            guard let uiImage = uiImage else {
                return
            }
            
            // update the image
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

// helper
struct RemoteImage: View {
    var image: Image?
    var body: some View {
        // show default image if failed to retrieve image
        image?.resizable() ?? Image("food-placeholder").resizable()
    }
}

struct AppetizerRemoteImage: View {
    @StateObject var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.load(fromURLString: urlString)
            }
    }
}
