//
//  SpotifyCategoryCell.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-27.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    
    var title: String = "all"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        VStack(spacing: 40) {
            SpotifyCategoryCell(title: "Title goes here")
            SpotifyCategoryCell(title: "Title goes here", isSelected: true)
            SpotifyCategoryCell(isSelected: true)
        }
    }
}
