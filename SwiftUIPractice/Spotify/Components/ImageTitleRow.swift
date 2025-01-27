//
//  ImageTitleRow.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-27.
//

import SwiftUI

struct ImageTitleRow: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var productName: String = "Some product"
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            Text(productName)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .padding(4)
                .lineLimit(2)
        }
        .frame(maxWidth: imageSize)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        ImageTitleRow()
    }
}
