//
//  NetflixRowCell.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-03.
//

import SwiftUI

struct NetflixRowCell: View {
    
    var width: CGFloat = 90
    var height: CGFloat = 140
    var imageName: String = Constants.randomImage
    var title: String? = "Movie Title"
    var isRecentlyAdded: Bool = true
    
    var topTenRanking: Int? = nil
    
    var body: some View {
        HStack(alignment: .bottom, spacing: -8) {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: 100, weight: .medium, design: .serif))
                    .offset(y: 20)
            }
            
            ImageLoaderView(urlString: imageName)
                .frame(width: width, height: height)
                .overlay(alignment: .bottom) {
                    VStack(spacing: 4) {
                        if let title, let firstWord = title.components(separatedBy: " ").first {
                            Text(firstWord)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .lineLimit(1)
                        }
                        
                        Text("Recently added")
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .padding(.bottom, 2)
                            .font(.caption2)
                            .frame(maxWidth: .infinity)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .background(.netflixRed)
                            .clipShape(.rect(cornerRadius: 2))
                            .padding(.horizontal, 8)
                            .offset(y: 2)
                            .opacity(isRecentlyAdded ? 1 : 0)
                        
                    }
                    .foregroundStyle(.netflixWhite)
                    .padding(.top, 6)
                    .background(
                        LinearGradient(colors: [.netflixBlack.opacity(0), .netflixBlack.opacity(0.3), .netflixBlack.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                    )
                }
                .clipShape(.rect(cornerRadius: 4))
        }
    }
}

#Preview {
    VStack {
        NetflixRowCell(isRecentlyAdded: true, topTenRanking: 10)
        NetflixRowCell(isRecentlyAdded: true, topTenRanking: 2)
        NetflixRowCell(isRecentlyAdded: true)
    }
}
