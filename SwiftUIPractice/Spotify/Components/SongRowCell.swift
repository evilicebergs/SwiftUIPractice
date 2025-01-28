//
//  SongRowCell.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-28.
//

import SwiftUI

struct SongRowCell: View {
    
    var imageSize: CGFloat = 55
    var imageName: String = Constants.randomImage
    var songname: String = "Some name"
    var artist: String? = "Some artist name"
    
    var onEllipsisClicked: (() -> Void)? = nil
    var onCellTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            VStack(alignment: .leading, spacing: 4) {
                Text(songname)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.spotifyWhite)
                    .lineLimit(2)
                if let artist {
                    Text(artist)
                        .foregroundStyle(.spotifyLightGray)
                        .font(.callout)
                        .lineLimit(2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotifyLightGray)
                .padding(16)
                .onTapGesture {
                    onEllipsisClicked?()
                    print("ellipsis tapped")
                }
        }
        .onTapGesture {
            onCellTapped?()
            print("cell tapped")
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        ScrollView {
            LazyVStack {
                SongRowCell()
                SongRowCell()
                SongRowCell()
                SongRowCell()
                SongRowCell()
                SongRowCell()
                SongRowCell()
                SongRowCell()
            }
        }
        .padding()
    }
}
