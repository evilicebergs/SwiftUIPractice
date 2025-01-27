//
//  SpotifyNewReleaseCell.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-27.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    
    var imageName: String = Constants.randomImage
    var headline: String? = "New Release From"
    var subheadline: String? = "Some Artist"
    
    var title: String? = "Some playlist"
    var subtitle: String? = "Single - title"
    
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    @State private var isClicked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                VStack(alignment: .leading, spacing: 2) {
                    if let headline {
                        Text(headline)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.callout)
                    }
                    if let subheadline {
                        Text(subheadline)
                            .foregroundStyle(.spotifyWhite)
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                }
            }
            
            HStack {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140)
                
                VStack(alignment: .leading, spacing: 2) {
                    if let title {
                        Text(title)
                            .foregroundStyle(.spotifyWhite)
                            .padding(.top, 8)
                            .padding(.leading, 10)
                    }
                    if let subtitle {
                        Text(subtitle)
                            .foregroundStyle(.spotifyLightGray)
                            .padding(.leading, 10)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            onAddToPlaylistPressed?()
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.spotifyLightGray)
                                .font(.title3)
                                .imageScale(.large)
                                .padding(4)
                                .offset(x: -4)
                        }
                        
                        Spacer()
                        
                        Image(systemName: isClicked ? "pause.circle.fill" : "play.circle.fill")
                            .foregroundStyle(.spotifyWhite)
                            .font(.title)
                            .imageScale(.large)
                            .padding(.trailing, 10)
                            .padding(.bottom, 8)
                            .animation(.default, value: isClicked)
                    }
                }
                .font(.callout)
                //.background(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 140)
            .background(.spotifyDarkGray)
            .clipShape(.rect(cornerRadius: 16))
            .onTapGesture {
                onPlayPressed?()
                isClicked.toggle()
            }
            
        }
        //.background(.red)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        SpotifyNewReleaseCell()
            .padding()
    }
}
