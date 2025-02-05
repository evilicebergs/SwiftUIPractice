//
//  ShareButton.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-04.
//

import SwiftUI

struct ShareButton: View {
    
    var url: String = "https://www.swiftui.dev"
    
    var body: some View {
        if let safeURL = URL(string: url) {
            ShareLink(item: safeURL) {
                VStack(spacing: 8) {
                    Image(systemName: "paperplane")
                        .font(.title)
                    
                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(.black.opacity(0.00001))
            }
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        ShareButton()
    }
}
