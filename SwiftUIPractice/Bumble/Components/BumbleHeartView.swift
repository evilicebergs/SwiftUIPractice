//
//  BumbleHeartView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-30.
//

import SwiftUI

struct BumbleHeartView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.bumbleYellow)
                .frame(width: 40, height: 40)
            
            Image(systemName: "bubble.fill")
                .foregroundStyle(.bumbleBlack)
                .font(.system(size: 22))
                .offset(y: 2)
            
            Image(systemName: "heart.fill")
                .foregroundStyle(.bumbleYellow)
                .imageScale(.small)
                .font(.system(size: 12))
        }
    }
}

#Preview {
    BumbleHeartView()
}
