//
//  BumbleProfileImageCell.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-31.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    
    var imageName = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    
    var cellSize: CGFloat = 100
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                Circle()
                    .stroke(lineWidth: 3)
                    .foregroundStyle(.bumbleGray)
                
                Circle()
                    .trim(from: 0, to: percentageRemaining)
                    .stroke(lineWidth: 4)
                    .rotationEffect(Angle(degrees: -90))
                    .foregroundStyle(.bumbleYellow)
                
                ImageLoaderView(urlString: imageName)
                    .clipShape(.circle)
                    .frame(width: cellSize-10, height: cellSize-10)
            }
            if hasNewMessage {
                ZStack {
                    Circle()
                        .foregroundStyle(.bumbleWhite)
                        .frame(width: cellSize/3.5, height: cellSize/3.5)
                    
                    Circle()
                        .foregroundStyle(.bumbleYellow)
                        .frame(width: cellSize/5, height: cellSize/5)
                }
                .offset(x: 2, y: -2)
            }
                
        }
        .frame(width: cellSize, height: cellSize)
            
    }
}

#Preview {
    VStack {
        BumbleProfileImageCell(cellSize: 100)
        
        BumbleProfileImageCell(percentageRemaining: 0.3, hasNewMessage: true, cellSize: 100)
    }
}
