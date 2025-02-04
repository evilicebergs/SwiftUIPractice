//
//  NetflixDetailsProducView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-04.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailsProducView: View {
    
    var title: String = "Movie Title"
    var isNew: Bool = true
    var yearReleased: String? = "2025"
    var seasonsCount: Int? = 2
    var hasClosedCaptions: Bool = true
    var isTopTen: Int? = 6
    var descriptionText: String? = "This is movie description for the Netflix app and it should be very long"
    var castText: String? = "Cast: Nick, Artem, Valera"
    var onPlayPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.medium)
                .font(.headline)
            
            HStack(spacing: 8) {
                if isNew {
                    Text("New")
                        .foregroundStyle(.green)
                }
                if let yearReleased {
                    Text(yearReleased)
                }
                
                if let seasonsCount {
                    if seasonsCount == 1 {
                        Text("\(seasonsCount) Season")
                    } else {
                        Text("\(seasonsCount) Seasons")
                    }
                }
                
                if hasClosedCaptions {
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGray)
            
            if let isTopTen {
                HStack {
                    topTenIcon
                    
                    Text("#\(isTopTen) in TV Shows Today")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
            HStack {
                Image(systemName: "play.fill")
                Text("Play")
                    .fontWeight(.medium)
            }
            .foregroundStyle(.netflixBlack)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(.netflixWhite)
            .clipShape(.rect(cornerRadius: 4))
            .asButton(.press) {
                onPlayPressed?()
            }
            
            HStack {
                Image(systemName: "arrow.down.to.line.alt")
                Text("Download")
                    .fontWeight(.medium)
            }
            .foregroundStyle(.netflixWhite)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(.netflixDarkGray)
            .clipShape(.rect(cornerRadius: 4))
            .asButton(.press) {
                onDownloadPressed?()
            }
            Group {
                if let descriptionText {
                    Text(descriptionText)
                }
                if let castText {
                    Text(castText)
                        .foregroundStyle(.netflixLightGray)
                }
            }
            .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.netflixWhite)
    }
    
    private var topTenIcon: some View {
        Rectangle()
            .foregroundStyle(.netflixRed)
            .frame(width: 28, height: 28)
            .overlay(alignment: .center) {
                VStack(spacing: -4) {
                    Text("TOP")
                        .font(.system(size: 8))
                        .fontWeight(.bold)
                    Text("10")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                }
                .offset(y: 1)
            }
    }
    
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        VStack {
            NetflixDetailsProducView()
       
            NetflixDetailsProducView()
            
            NetflixDetailsProducView(
                title: "Title",
                isNew: false,
                yearReleased: nil,
                seasonsCount: nil,
                hasClosedCaptions: false,
                isTopTen: nil,
                descriptionText: nil,
                castText: nil,
                onPlayPressed: nil,
                onDownloadPressed: nil
            )
        }
        .padding(4)
    }
}
