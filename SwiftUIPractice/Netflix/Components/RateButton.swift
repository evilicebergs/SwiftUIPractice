//
//  RateButton.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-04.
//

import SwiftUI

enum RateOption: String, CaseIterable {
    case disslike, like, love
    
    var title: String {
        switch self {
        case .disslike:
            return "Not for me"
        case .like:
            return "I like this"
        case .love:
            return "Love this!"
        }
    }
    
    var iconName: String {
        switch self {
        case .disslike:
            return "hand.thumbsdown"
        case .like:
            return "hand.thumbsup"
        case .love:
            return "bolt.heart"
        }
    }
}

struct RateButton: View {
    
    @State private var isPresented: Bool = false
    var onRatingSelected: ((RateOption) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "hand.thumbsup")
                .font(.title)
            
            Text("Rate")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.black.opacity(0.00001))
        .onTapGesture {
            isPresented.toggle()
        }
        .popover(isPresented: $isPresented) {
            ZStack {
                Color.netflixDarkGray.ignoresSafeArea()
                
                HStack(spacing: 4) {
                    ForEach(RateOption.allCases, id: \.hashValue) { option in
                        imageIcon(systemName: option.iconName, text: option.title) {
                            onRatingSelected?(option)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .presentationCompactAdaptation(.popover)
            
        }
    }
    
    private func imageIcon(systemName: String, text: String, action: (() -> Void)?) -> some View {
        VStack(spacing: 8) {
            Image(systemName: systemName)
                .font(.title2)
            Text(text)
                .font(.caption)
        }
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(.black.opacity(0.00001))
        .onTapGesture {
            isPresented = false
            
            action?()
        }
    }
    
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        RateButton()
    }
        
}

