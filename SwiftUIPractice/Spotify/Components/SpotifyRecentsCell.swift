//
//  SpotifyRecentsCell.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-27.
//

import SwiftUI
import SwiftfulUI

struct SpotifyRecentsCell: View {
    
    var imageName: String = Constants.randomImage
    var title: String = "Some title"
    
    var body: some View {
        HStack(spacing: 16, content: {
            ImageLoaderView(urlString: imageName)
                .scaledToFit()
                .frame(width: 55, height: 55)
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
        })
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
            .themeColors(isSelected: false)
            .clipShape(.rect(cornerRadius: 6))
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        VStack {
            HStack {
                SpotifyRecentsCell(title: "fgkfgjafkljglkjflgkdkfjgafkajgfa;kfagfkagfjafg;akf")
                SpotifyRecentsCell()
            }
            HStack {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
        }
        //        LazyVGrid(columns: [GridItem(), GridItem()]) {
        //            ForEach(0..<6) { _ in
        //                SpotifyRecentsCell()
        //                    .frame(height: 50)
        //            }
        //        }
    }
}
