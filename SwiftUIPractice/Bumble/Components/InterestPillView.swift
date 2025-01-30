//
//  InterestPillView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-30.
//

import SwiftUI

struct InterestPillView: View {
    
    var iconName: String? = "heart.fill"
    var emojiName: String? = "✅"
    var title: String = "Graduation Degree"
    
    var body: some View {
        HStack(spacing: 4) {
            if let iconName {
                Image(systemName: iconName)
            } else if let emojiName {
                Text(emojiName)
            }
            
            Text(title)
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(.bumbleLightYellow)
        .clipShape(.rect(cornerRadius: 36))
    }
}

#Preview {
    InterestPillView(iconName: "graduationcap", title: "Running")
    
    InterestPillView(iconName: nil, emojiName: "🌸", title: "Gym")
    
    InterestPillView(title: "Gym")
}
