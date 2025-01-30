//
//  InterestPillGridView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-30.
//

import SwiftUI
import SwiftfulUI

struct UserInterest: Identifiable {
    let id = UUID().uuidString
    var iconName: String? = nil
    var emoji: String? = nil
    let text: String
}

struct InterestPillGridView: View {
    
    var interests: [UserInterest] = User.mock.interests
    
    
    var body: some View {
        ZStack {
            NonLazyVGrid(columns: 2, alignment: .leading, items: interests) { interest in
                if let interest {
                    InterestPillView(
                        iconName: interest.iconName,
                        emojiName: interest.emoji,
                        title: interest.text
                    )
                } else {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        InterestPillGridView(interests: User.mock.basics)
        InterestPillGridView(interests: User.mock.interests)
    }
}
