//
//  NetflixNewReleaseCell.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-03.
//

import SwiftUI

struct NetflixNewReleaseCell: View {
    
    var title: String = "Stranger Things"
    var imageName: String = Constants.randomImage
    var isNetfixFilm: Bool = true
    var categories: [String] = ["Science Fiction", "Comedy", "Drama"]
    
    var onBackGroundPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    var onMyListPressed: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(urlString: imageName)
            
            VStack(spacing: 16) {
                VStack {
                    if isNetfixFilm {
                        HStack(alignment: .center, spacing: 0) {
                            Text("N ")
                                .font(.largeTitle)
                                .foregroundStyle(.netflixRed)
                                .fontWeight(.black)
                            
                            Text("FILM")
                                .kerning(3)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.netflixLightGray)
                        }
                    }
                    
                    Text(title)
                        .font(.system(size: 40, weight: .medium, design: .serif))
                        .bold()
                }
                HStack {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                            .font(.callout)
                        
                        if categories.last != category {
                            Circle()
                                .frame(width: 6, height: 6)
                        }
                    }
                }
                HStack(spacing: 16) {
                    Button {
                        onPlayPressed?()
                    } label: {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                        .foregroundStyle(.netflixBlack)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(.netflixWhite)
                        .clipShape(.rect(cornerRadius: 4))
                    }
                    
                    Button {
                        onMyListPressed?()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("My List")
                        }
                        .foregroundStyle(.netflixWhite)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(.netflixDarkGray)
                        .clipShape(.rect(cornerRadius: 4))
                    }

                }
                .font(.callout)
                .fontWeight(.medium)
            }
            .foregroundStyle(.netflixWhite)
            .padding(24)
            .background(
                LinearGradient(colors: [.netflixBlack.opacity(0.001), .netflixBlack.opacity(0.4), .netflixBlack.opacity(0.4), .netflixBlack.opacity(0.4)], startPoint: .top, endPoint: .bottom)
            )
        }
        .clipShape(.rect(cornerRadius: 8))
        .aspectRatio(0.8, contentMode: .fit)
        .onTapGesture {
            onBackGroundPressed?()
        }
    }
}

#Preview {
    NetflixNewReleaseCell()
        .padding(.horizontal, 16)
}
