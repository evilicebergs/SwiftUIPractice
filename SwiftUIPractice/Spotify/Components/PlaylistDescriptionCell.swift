//
//  PlaylistDescriptionCell.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-28.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    
    var descriptionText: String = Product.mock.description
    var userName: String = "Terry"
    var subheadline: String = "Some Headline Goes Here"
    
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    var onSharePressed: (() -> Void)? = nil
    var onEllipsPressed: (() -> Void)? = nil
    var onShufflePressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    @State private var playIsClicked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(descriptionText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            madeForYouSection
            
            Text(subheadline)
            
            buttonsRow
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLightGray)
    }
    
    private var madeForYouSection: some View {
        HStack(spacing: 8) {
            Image(systemName: "apple.logo")
                .foregroundStyle(.spotifyGreen)
                .font(.title3)
            Text("Made for ")
            +
            Text(userName)
                .fontWeight(.bold)
                .foregroundStyle(.spotifyWhite)
        }
    }
    
    private var buttonsRow: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    onAddToPlaylistPressed?()
                } label: {
                    Image(systemName: "plus.circle")
                        .padding(8)
                }
                
                Button {
                    onDownloadPressed?()
                } label: {
                    Image(systemName: "arrow.down.circle")
                        .padding(8)
                }
                
                Button {
                    onSharePressed?()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .padding(8)
                }
                
                Button {
                    onEllipsPressed?()
                } label: {
                    Image(systemName: "ellipsis")
                        .padding(8)
                        
                }

            }
            .font(.title2)
            .offset(x: -8)
            //.frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            HStack(spacing: 8) {
                
                Button {
                    onShufflePressed?()
                } label: {
                    Image(systemName: "shuffle")
                        .font(.system(size: 26))
                        
                }

                Image(systemName: playIsClicked ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 46))
                    .onTapGesture {
                        onPlayPressed?()
                        
                        playIsClicked.toggle()
                    }
                    .animation(.default, value: playIsClicked)
                
            }
            .foregroundStyle(.spotifyGreen)
            .offset(x: 4)
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        PlaylistDescriptionCell()
            .padding()
    }

}
