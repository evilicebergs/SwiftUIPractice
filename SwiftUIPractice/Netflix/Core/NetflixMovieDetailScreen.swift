//
//  NetflixMovieDetailScreen.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-04.
//

import SwiftUI

struct NetflixMovieDetailScreen: View {
    
    var product: Product = .mock
    
    @State private var progress: Double = 0.2
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                NetflixDetailsHeaderView(
                    image: product.image,
                    progress: progress) {
                        
                    } xmarkPressed: {
                        
                    }
                
                ScrollView(.vertical) {
                    VStack(spacing: 16) {
                        NetflixDetailsProducView(
                            title: product.title,
                            isNew: Bool.random(),
                            yearReleased: "2023",
                            seasonsCount: product.stock,
                            hasClosedCaptions: Bool.random(),
                            isTopTen: Bool.random() ? Int.random(in: 1...10) : nil,
                            descriptionText: product.description,
                            castText: product.brand) {
                                
                            } onDownloadPressed: {
                                
                            }
                    }
                    .padding(8)

                }
                .scrollIndicators(.hidden)

                
            }
        }
    }
}

#Preview {
    NetflixMovieDetailScreen()
}
